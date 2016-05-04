package com.xmbl.ops.controller.tool;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xmbl.ops.controller.organization.AbstractController;
import com.xmbl.ops.dto.Server;
import com.xmbl.ops.model.mongo.GameCdkey;
import com.xmbl.ops.service.tool.GameServersService;
import com.xmbl.ops.util.DateUtils;
@Controller
@RequestMapping(value = "/tool")
public class GameCdkeyController extends AbstractController{
	private static int limit = 50;
	@Autowired
	protected GameServersService gameServersService;
//	@Autowired
//	protected GameCdkeyService gameCdkeyService;
//	
//	
//	@RequestMapping(value = "/gameCdkeyInfoList")
//	public String gameCdkeysSearch(HttpServletRequest request, ModelMap model, Long gameserverId, String cdkey,  String cdkeyName,
//			 String startTime, String endTime,  Long page) throws Exception {
//		Date startDate = DateUtils.parseDate(startTime, "yyyy-MM-dd HH:mm:ss");
//		Date endDate = DateUtils.parseDate(endTime, "yyyy-MM-dd HH:mm:ss");
//		page = page == null || page < 0 ? 0 : page;
//		long totalNum =  gameCdkeyService.searchCount(gameserverId, startDate, endDate, cdkey, cdkeyName);
//		long totalPageNum = totalNum / limit;
//		if (totalNum > totalPageNum * limit) totalPageNum++;
//		if (page >= totalPageNum && totalPageNum != 0) page = totalPageNum - 1;
//		if (totalNum > totalPageNum * limit)
//			totalPageNum++;
//		if (page >= totalPageNum && totalPageNum != 0)
//			page = totalPageNum - 1;
//		int start =(int)(page * limit);
//		List<GameCdkey> gameCdkeyList = gameCdkeyService.searchList(gameserverId, startDate, endDate, cdkey, cdkeyName, start, limit);
//		model.addAttribute("gameserverId", gameserverId);
//		model.addAttribute("cdkey", cdkey);
//		model.addAttribute("cdkeyName", cdkeyName);
//		model.addAttribute("startTime", startTime);
//		model.addAttribute("endTime", endTime);
//		model.addAttribute("gameCdkeyList", gameCdkeyList);
//		model.addAttribute("page", page);
//		model.addAttribute("totalNum", totalNum);
//		model.addAttribute("totalpage", totalPageNum);
//		return "tool/gameCdkeyList";
//	}
//	
//	
//	@RequestMapping(value = "/gameCdkeyInfo") 
//	public String gameBannedInfo(HttpServletRequest request, ModelMap model, Long id) throws Exception {
//		List<Server> gameServers = gameServersService.getGameServerList();
//		List<Map<String, Object>> result = new ArrayList<>();
//		if (gameServers != null) {
//			model.addAttribute("gameServerList", gameServers);
//		}
//		String referer = request.getHeader("referer");
//		model.addAttribute("referer", referer);
//		return "tool/addGameCdkey" ;
//	}
}
