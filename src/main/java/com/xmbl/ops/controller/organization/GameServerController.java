package com.xmbl.ops.controller.organization;

import com.xmbl.ops.constant.SessionConstant;
import com.xmbl.ops.dto.ResponseResult;
import com.xmbl.ops.enumeration.EnumResCode;
import com.xmbl.ops.model.organization.GameServer;
import com.xmbl.ops.service.game.GameServerService;
import com.xmbl.ops.util.Common;
import com.xmbl.ops.util.DateUtils;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.util.*;

@Controller
@RequestMapping(value = "/game")
public class GameServerController extends AbstractController {
	private static final int limit = 30;
	
	@Autowired
	protected GameServerService gameServerService;
	@Autowired
	protected StringRedisTemplate redisTemplate;
	@RequestMapping(value = "/gameServerList")
	public String gameServerList(HttpServletRequest request, ModelMap model,Long id, Long serverId, String serverName, Integer status , Long page) throws Exception {
		HttpSession session = request.getSession();
		try {
				page = page == null || page < 0 ? 0 : page;
				long totalNum = gameServerService.searchCount(id, serverId, serverName, status);
				long totalPageNum = totalNum / limit;
				if (totalNum > totalPageNum * limit)
					totalPageNum++;
				if (page >= totalPageNum && totalPageNum != 0)
					page = totalPageNum - 1;
				long start = page * limit;
				List<GameServer> gameServerList = gameServerService.searchList(id, serverId, serverName, status, start,
						limit);
				model.addAttribute("serverId", serverId);
				model.addAttribute("serverName", serverName);
				model.addAttribute("status", status);
				model.addAttribute("gameServerList", gameServerList);
				model.addAttribute("page", page);
				model.addAttribute("totalNum", totalNum);
				model.addAttribute("totalpage", totalPageNum);
				return "game/gameServerList";
		} catch (Exception e) {
			e.printStackTrace();
			return "index";
		}
	}

	@RequestMapping(value = "gameServerInfo") 
	public String gameServerInfo(HttpServletRequest request, ModelMap model, Long id) {
		if(id != null) {
			GameServer gameserver = gameServerService.getGameServerById(id);
			if( gameserver != null) {
				model.addAttribute("gameserver", gameserver);
				saveRedis(gameserver);
			}
		}
		String referer = request.getHeader("referer");
		model.addAttribute("referer", referer);
		return "game/gameServerDetail" ;
	}

	@RequestMapping(value = "/editGameServer")
	public @ResponseBody
	ResponseResult editGameServer(HttpServletRequest request, ModelMap model, Long Id, Long serverId, String serverName,
			String serverIp, String serverPort, Byte status, String createTime) {
		try {
			HttpSession session = request.getSession();
			String operatorName = (String) session.getAttribute(SessionConstant.USER_NAME);
			//有id为编辑
			if (serverId == null) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "服务器ID不能为空");
			}
			if (StringUtils.isEmpty(serverName)) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "服务器名不能为空");
			}
			if (!Common.isIP(serverIp)) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "服务器名Ip不正确");
			}
			if (StringUtils.isEmpty(createTime)) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "开服时间不能为空");
			}
			Date startDate = DateUtils.parseDate(createTime, "yyyy-MM-dd HH:mm:ss");
			if (Id != null) {
				GameServer gameserver = new GameServer(Id,serverId,serverName,serverIp,serverPort,startDate,status,operatorName);
				boolean updateSuccess = gameServerService.editGameServer(gameserver);
				if(updateSuccess) {
					return successJson();
				}else{
					return errorJson(EnumResCode.SERVER_ERROR.value(), "编辑服务器失败");
				}
			} else {
				GameServer gameserver = new GameServer(serverId,serverName,serverIp,serverPort,startDate,status,operatorName);
				gameserver = gameServerService.insertGameServer(gameserver);
				if(gameserver != null) {
					return successJson();
				}else{
					return errorJson(EnumResCode.SERVER_ERROR.value(), "添加服务器失败");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	@RequestMapping(value = "/updateGameServerStatus")
	public @ResponseBody ResponseResult updateGameServerStatus(HttpServletRequest request, ModelMap model, String gameserverIds, Integer status) throws Exception {
		HttpSession session = request.getSession();
		String operatorName = (String) session.getAttribute(SessionConstant.USER_NAME);
		if (StringUtils.isEmpty(gameserverIds)) {
			return errorJson(EnumResCode.SERVER_ERROR.value(), "服务器id参数异常");
		}
		if (status == null) {
			return errorJson(EnumResCode.SERVER_ERROR.value(), "状态参数异常");
		}
		String[] gameServerIdsArray = gameserverIds.split(",");
		Long[] Ids = new Long[gameServerIdsArray.length];
		for (int i = 0; i < gameServerIdsArray.length; i++) {
			if (StringUtils.isEmpty(gameServerIdsArray[i])
					|| !StringUtils.isNumeric(gameServerIdsArray[i])) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "参数异常");
			}
			Ids[i] = Long.valueOf(gameServerIdsArray[i]);
		}
		gameServerService.auditGameServers(Ids,status,operatorName);
		return successJson();
	}
	

	private void saveRedis(GameServer gameserver) {
		redisTemplate.delete("name");
		String e = "{\"picture_url\": \""+gameserver+"\"}";
        redisTemplate.opsForList().leftPush("name1", e);
    	JSONObject result = new JSONObject();
		result.put("username", 11);
		result.put("time", gameserver);
//		redisClient.set("name11",result.toString(),0);//向key-->name中放入了value-->xinxin 
		System.out.print(result.toString());
	}
	
	/*
	 * 获取服务器列表
	 */
	@RequestMapping(value = "/getGameServerList")
	public @ResponseBody
	ResponseResult getGameServerList() {
		try {
			List<GameServer> gameServers = gameServerService.getGameServerList();
			List<Map<String, Object>> result = new ArrayList<>();
			if (gameServers != null) {
				for (GameServer gameserverInfo : gameServers) {
					Map<String, Object> map = new HashMap<>();
					map.put("id", gameserverInfo.getId());
					map.put("name", gameserverInfo.getServername());
					result.add(map);
				}
				return successJson(result);
			}
			return successJson(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return errorJson(EnumResCode.SERVER_ERROR.value(), "获取服务器列表失败！");
	}
}
