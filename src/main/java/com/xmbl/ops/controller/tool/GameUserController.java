package com.xmbl.ops.controller.tool;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.xmbl.ops.model.mongo.Users;
import com.xmbl.ops.service.tool.UsersService;
import com.xmbl.ops.util.DateUtils;
import com.xmbl.ops.controller.organization.AbstractController;
import com.xmbl.ops.dto.Player;


@Controller
@RequestMapping(value = "/tool")
public class GameUserController extends AbstractController{
	private static int limit = 50;
	@Autowired
	protected UsersService usersService;
	
	@RequestMapping(value = "/usersInfoList")
	public String usersSearch(HttpServletRequest request, ModelMap model, String userId, String deviceId, String mobile, 
			String loginname, String channel, Integer scoreStart, Integer scoreEnd, String isBlock,
			String isMobilebind, String isBind, Integer sysType, Integer status, String version, String startTime,
			String endTime,  Long page) throws Exception {
		long totalNum = 0;
		Date startDate = DateUtils.parseDate(startTime, "yyyy-MM-dd HH:mm:ss");
		Date endDate = DateUtils.parseDate(endTime, "yyyy-MM-dd HH:mm:ss");
		page = page == null || page < 0 ? 0 : page;

		long totalPageNum = totalNum / limit;
		if (totalNum > totalPageNum * limit) totalPageNum++;
		if (page >= totalPageNum && totalPageNum != 0) page = totalPageNum - 1;
		if (totalNum > totalPageNum * limit)
			totalPageNum++;
		if (page >= totalPageNum && totalPageNum != 0)
			page = totalPageNum - 1;
		int start =(int)(page * limit);
		List<Users> usersList = null;
//		List<Users> usersList = usersService.searchList(userId, deviceId, mobile, 
//				 loginname, channel, scoreStart, scoreEnd, isBlock,
//				 isMobilebind, isBind, sysType, status, version, startDate,
//				 endDate, start, limit);
		
		model.addAttribute("userId", userId);
		model.addAttribute("gameId", deviceId);
		model.addAttribute("usersList", usersList);
		model.addAttribute("page", page);
		model.addAttribute("totalNum", totalNum);
		model.addAttribute("totalpage", totalPageNum);
		return "tool/usersList";
	}
	
	//获取个人详细
	@RequestMapping(value = "/userDetail")
	public String userDetail(HttpServletRequest request, ModelMap model, Integer serverId, Long paleyId) throws Exception {
		Player player = usersService.getPlayerById(serverId,paleyId);
//	    if(users != null){
	    	model.addAttribute("player", player);
//	    	model.addAttribute("isMobilebind", users.is_mobilebind());
//	    	model.addAttribute("isBind", users.is_bind());
//	    	model.addAttribute("isBlock", users.is_block());
//	    	if(users.getPhone_type() == 1 ) {
//	    		model.addAttribute("phoneType", "android");	    		
//	    	}else if (users.getPhone_type() == 2) {
//	    		model.addAttribute("phoneType", "IOS");	  
//	    	}
	    	
	    	return "tool/userDetail";
//	    }
//	    return null;
	}
}
