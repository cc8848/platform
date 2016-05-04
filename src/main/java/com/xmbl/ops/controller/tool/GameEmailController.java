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
import com.xmbl.ops.model.mongo.GameEmail;
import com.xmbl.ops.service.tool.GameEmailService;
import com.xmbl.ops.service.tool.GameServersService;
import com.xmbl.ops.util.DateUtils;

@Controller
@RequestMapping(value = "/tool")
public class GameEmailController extends AbstractController{
	private static int limit = 50;
	@Autowired
	protected GameServersService gameServersService;
	@Autowired
	protected GameEmailService gameEmailService;
	
	@RequestMapping(value = "/emailInfoList")
	public String emailsSearch(HttpServletRequest request, ModelMap model, Long gameserverId, String content,
			Integer status, String startTime,
			String endTime,  Long page) throws Exception {
		Date startDate = DateUtils.parseDate(startTime, "yyyy-MM-dd HH:mm:ss");
		Date endDate = DateUtils.parseDate(endTime, "yyyy-MM-dd HH:mm:ss");
		page = page == null || page < 0 ? 0 : page;
		long totalNum =  gameEmailService.searchCount(gameserverId,  startDate,
				 endDate , content);
		long totalPageNum = totalNum / limit;
		if (totalNum > totalPageNum * limit) totalPageNum++;
		if (page >= totalPageNum && totalPageNum != 0) page = totalPageNum - 1;
		if (totalNum > totalPageNum * limit)
			totalPageNum++;
		if (page >= totalPageNum && totalPageNum != 0)
			page = totalPageNum - 1;
		int start =(int)(page * limit);
		List<GameEmail> emailList = gameEmailService.searchList(gameserverId, startDate, endDate, content, start, limit);
		model.addAttribute("gameserverId", gameserverId);
		model.addAttribute("content", content);
		model.addAttribute("startTime", startTime);
		model.addAttribute("endTime", endTime);
		model.addAttribute("emailList", emailList);
		model.addAttribute("page", page);
		model.addAttribute("totalNum", totalNum);
		model.addAttribute("totalpage", totalPageNum);
		return "tool/emailList";
	}
	
	
	@RequestMapping(value = "/emailInfo") 
	public String emailInfo(HttpServletRequest request, ModelMap model, Long id) throws Exception {
		List<Server> gameServers = gameServersService.getGameServerList();
		List<Map<String, Object>> result = new ArrayList<>();
		if (gameServers != null) {
			model.addAttribute("gameServerList", gameServers);
		}
		String referer = request.getHeader("referer");
		model.addAttribute("referer", referer);
		return "tool/addGameEmail" ;
	}
	
	@RequestMapping(value = "/addGameEmail") 
	public @ResponseBody ResponseResult addGameEmailInfo(HttpServletRequest request, ModelMap model, String content, String gameserverIdArray, String createTime) throws Exception {
		try {
			HttpSession session = request.getSession();
			String operatorName = (String) session.getAttribute(SessionConstant.USER_NAME);
			if (StringUtils.isEmpty(content)) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "邮件内容不能为空");
			}
			if (StringUtils.isEmpty(gameserverIdArray)) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "服务器至少选一个");
			}
			if (StringUtils.isEmpty(createTime)) {
				return errorJson(EnumResCode.SERVER_ERROR.value(), "公告时间不能为空");
			}
			Date startDate = DateUtils.parseDate(createTime, "yyyy-MM-dd HH:mm:ss");
			String[] gameServerIdsArray = gameserverIdArray.split(",");
			Long[] ServerIds = new Long[gameServerIdsArray.length];
			for (int i = 0; i < gameServerIdsArray.length; i++) {
				if (StringUtils.isEmpty(gameServerIdsArray[i])
						|| !StringUtils.isNumeric(gameServerIdsArray[i])) {
					return errorJson(EnumResCode.SERVER_ERROR.value(), "参数异常");
				}
				ServerIds[i] = Long.valueOf(gameServerIdsArray[i]);
			}
			gameEmailService.addGameEmail(ServerIds,content,startDate,operatorName);
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
		return successJson();
	}
}
