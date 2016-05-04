package com.xmbl.ops.controller.tool;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xmbl.ops.constant.SessionConstant;
import com.xmbl.ops.controller.organization.AbstractController;
import com.xmbl.ops.dto.ResponseResult;
import com.xmbl.ops.dto.Server;
import com.xmbl.ops.enumeration.EnumResCode;
import com.xmbl.ops.model.mongo.GameBanned;
import com.xmbl.ops.service.tool.GameBannedService;
import com.xmbl.ops.service.tool.GameServersService;
import com.xmbl.ops.util.DateUtils;
@Controller
@RequestMapping(value = "/tool")
public class GameBannedController extends AbstractController{
	private static int limit = 50;
	@Autowired
	protected GameServersService gameServersService;
	@Autowired
	protected GameBannedService gameBannedService;
	
	@RequestMapping(value = "/gameBannedInfoList")
	public String gameBannedsSearch(HttpServletRequest request, ModelMap model, Long gameserverId, String userId,  String nikeName,
			Integer type, String startTime,
			String endTime,  Long page) throws Exception {
		Date startDate = DateUtils.parseDate(startTime, "yyyy-MM-dd HH:mm:ss");
		Date endDate = DateUtils.parseDate(endTime, "yyyy-MM-dd HH:mm:ss");
		page = page == null || page < 0 ? 0 : page;
		long totalNum =  gameBannedService.searchCount(gameserverId, startDate, endDate, userId, nikeName, type);
		long totalPageNum = totalNum / limit;
		if (totalNum > totalPageNum * limit) totalPageNum++;
		if (page >= totalPageNum && totalPageNum != 0) page = totalPageNum - 1;
		if (totalNum > totalPageNum * limit)
			totalPageNum++;
		if (page >= totalPageNum && totalPageNum != 0)
			page = totalPageNum - 1;
		int start =(int)(page * limit);
		List<GameBanned> gameBannedList = gameBannedService.searchList(gameserverId, startDate, endDate, userId, nikeName, type, start, limit);
		model.addAttribute("gameserverId", gameserverId);
		model.addAttribute("userId", userId);
		model.addAttribute("nikeName", nikeName);
		model.addAttribute("type", type);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("gameBannedList", gameBannedList);
		model.addAttribute("page", page);
		model.addAttribute("totalNum", totalNum);
		model.addAttribute("totalpage", totalPageNum);
		return "tool/gameBannedList";
	}
	
	
	@RequestMapping(value = "/gameBannedInfo") 
	public String gameBannedInfo(HttpServletRequest request, ModelMap model, Long id) throws Exception {
		List<Server> gameServers = gameServersService.getGameServerList();
		List<Map<String, Object>> result = new ArrayList<>();
		if (gameServers != null) {
			model.addAttribute("gameServerList", gameServers);
		}
		String referer = request.getHeader("referer");
		model.addAttribute("referer", referer);
		return "tool/addGameBanned" ;
	}
	
	@RequestMapping(value = "/addGameBanned") 
	public @ResponseBody ResponseResult addGameBanned(HttpServletRequest request, ModelMap model, Long serverId, String userId, String nikeName,
			Integer type, String startTime, String endTime) throws Exception {
		try {
			HttpSession session = request.getSession();
			String operatorName = (String) session.getAttribute(SessionConstant.USER_NAME);
			if (serverId == null) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "服务器不能为空");
			}
			if (type == null) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "操作类型不能为空");
			}
			if (StringUtils.isEmpty(userId) && StringUtils.isEmpty(nikeName)) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "玩家id,玩家昵称至少有一个不为空");
			}
			
			//校验是否存在玩家
			
			if (StringUtils.isEmpty(startTime)) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "开始时间不能为空");
			}
			
			if (StringUtils.isEmpty(endTime)) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "结束时间不能为空");
			}
			Date startDate = DateUtils.parseDate(startTime, "yyyy-MM-dd HH:mm:ss");
			Date endDate = DateUtils.parseDate(endTime, "yyyy-MM-dd HH:mm:ss");
			
			if(!startDate.before(endDate)) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "结束时间不能小于开始时间");
			}
			
			if(!startDate.before(new Date())) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "开始时间不能小于当前时间");
			}
			
			gameBannedService.addGameBanned(serverId,userId,nikeName,type,startDate,endDate,operatorName);
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return successJson();
	}
}
