package com.xmbl.ops.service.tool;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.xmbl.ops.constant.RpcCommonConstant;
import com.xmbl.ops.dao.mongo.impl.UserDaoImpl;
import com.xmbl.ops.dto.Player;
import com.xmbl.ops.dto.Server;
import com.xmbl.ops.util.DateUtils;
import com.xmbl.ops.util.http.HttpSubmit;

@Service
public class UsersService {
	private static Logger logger = LoggerFactory.getLogger("palyer_log");	
	@Autowired
	protected GameServersService gameServersService;
	
	public Player getPlayerById(Integer serverId, Long paleyId) throws Exception {
		 //send 游戏服务器 返回成功插入
		Player player = null;
		Integer gameServerId = Integer.valueOf(serverId);
		if( gameServerId != null ) {
			Server gameServer = gameServersService.getGameServer(gameServerId);
			if(gameServer != null) {
//				String Result="";
				String Result="{\"PlayerId\":3333333,\"PlayerName\":\"a5\"}";
				Map<String, String> MSG_sParaTemp = null;
				Map<String, Object> MSG_sParaJson = null;
				MSG_sParaTemp = new HashMap<String, String>();
				JSONObject resObj = new JSONObject();	
				MSG_sParaTemp.put("params", "{'PlayerId':330000000000000030}");
//				Result=HttpSubmit.sendPostOrGetInfo_RPC(MSG_sParaTemp, RpcCommonConstant.PLAYERINFO, "POST");
				System.out.print(Result);
				resObj=JSON.parseObject(Result);
				Long playerId= Long.valueOf(resObj.getString("PlayerId").toString());
				String playerName= resObj.getString("PlayerName").toString();
				System.out.print(playerName);
			    player = new Player(playerId,playerName);
			}else{
				logger.error("日期，data={},gameServer={}", DateUtils.formatDate(new Date(), "yyyy-MM-dd hh:mm:ss"),gameServer);
			}
		}

		return player;
	}
	
//	@Resource
//	UserDaoImpl usersDao;
//	private void setIsBind(Users users) {
//		String isBind =String.valueOf(users.is_bind());
//    	if(isBind != null) {
//    		for(EnumIsTure isTure : EnumIsTure.values()) {
//    			if(isBind.equals(isTure.getIs())) {
//    				users.setIsBindStr(isTure.getDesc());
//    				break;
//    			}
//    		}
//    	}
//    }
//	
//	private void setIsMobilebind(Users users) {
//		String isBind =String.valueOf(users.is_mobilebind());
//    	if(isBind != null) {
//    		for(EnumIsTure isTure : EnumIsTure.values()) {
//    			if(isBind.equals(isTure.getIs())) {
//    				users.setIsMobilebindStr(isTure.getDesc());
//    				break;
//    			}
//    		}
//    	}
//    }
//	
//	private void setIsBlock(Users users) {
//		String isBind =String.valueOf(users.is_block());
//    	if(isBind != null) {
//    		for(EnumIsTure isTure : EnumIsTure.values()) {
//    			if(isBind.equals(isTure.getIs())) {
//    				users.setIsBlockStr(isTure.getDesc());
//    				break;
//    			}
//    		}
//    	}
//    }
//	
//	public long searchCount(String userId, String deviceId, String mobile, 
//			String loginname, String channel, Integer scoreStart, Integer scoreEnd, String isBlock,
//			String isMobilebind, String isBind, Integer sysType, Integer status, String version, Date startDate,
//			Date endDate) {
//		return usersDao.searchCount(userId, deviceId, mobile, 
//				 loginname, channel, scoreStart, scoreEnd, isBlock,
//				 isMobilebind, isBind, sysType, status, version, startDate,
//				 endDate);
//	}
//	
//	public List<Users> searchList(String userId, String deviceId, String mobile, 
//			String loginname, String channel, Integer scoreStart, Integer scoreEnd, String isBlock,
//			String isMobilebind, String isBind, Integer sysType, Integer status, String version, Date startDate,
//			Date endDate, int start,
//			int	limit) {
//		List<Users> usersList = usersDao.searchList(userId, deviceId, mobile, 
//				 loginname, channel, scoreStart, scoreEnd, isBlock,
//				 isMobilebind, isBind, sysType, status, version, startDate,
//				 endDate, start, limit);
//		for( Users users: usersList) {
//			setIsBind(users);
//			setIsBlock(users);
//			setIsMobilebind(users);
//			users.setCreateTimeStr(DateUtils.formatDate(users.getCreate_at()));
//		}
//		
//		return usersList;
//	}
//	

//
//	public Users getByNameAndMobile(String name, String mobile) {
//		return usersDao.searchUser(name, mobile);
//	}
//
//	public Users getByMobile(String mobile) {
//		return usersDao.searchUsersByPhone(mobile);
//	}
//	
//	public List<Users> searchSysUser() {
//		List<Users> sysUserList =  usersDao.searchSysUser();
//		List<Users> result = new ArrayList<>();
//		//过滤掉没有姓名的运营账号
//		for(Users user : sysUserList) {
//			if(StringUtils.isNotEmpty(user.getName())) {
//				result.add(user);
//			}
//		}
//		return result;
//	}
//	
//	public Users addUsers(String name, String loginname, String mobile, String profileImageUrl) {
//		Users users = usersDao.insertUsersInfo(name, loginname, mobile, profileImageUrl);
//		return users;
//	}
//	
//	public Users updateUsers(String userId, Boolean isBlock, int scoreAdd) {
//		Users users = usersDao.updateUsersInfo(userId, isBlock, scoreAdd);
//		return users;
//	}
}
