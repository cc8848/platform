package com.xmbl.ops.controller.tool;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xmbl.ops.constant.SessionConstant;
import com.xmbl.ops.controller.organization.AbstractController;
import com.xmbl.ops.dto.ResponseResult;
import com.xmbl.ops.dto.Server;
import com.xmbl.ops.enumeration.EnumResCode;
import com.xmbl.ops.service.tool.GameServersService;
import com.xmbl.ops.util.Common;
import com.xmbl.ops.util.DateUtils;
@Controller
@RequestMapping(value = "/tool")
public class GameServersController extends AbstractController{
private static final int limit = 30;
	
	@Autowired
	protected GameServersService gameServersService;
	
	/*
	 * 获取服务器列表
	 */
	@RequestMapping(value = "/getGameServerList")
	public @ResponseBody
	ResponseResult getGameServerList() {
		try {
			List<Server> gameServers = gameServersService.getGameServerList();
			List<Map<String, Object>> result = new ArrayList<>();
			if (gameServers != null) {
				for (Server gameserverInfo : gameServers) {
					Map<String, Object> map = new HashMap<>();
					map.put("id", gameserverInfo.getId());
					map.put("name", gameserverInfo.getName());
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
