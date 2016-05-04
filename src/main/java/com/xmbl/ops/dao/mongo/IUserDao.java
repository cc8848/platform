package com.xmbl.ops.dao.mongo;

import java.util.Date;
import java.util.List;

import com.xmbl.ops.dao.base.IEntityDao;
import com.xmbl.ops.model.mongo.Users;

public interface IUserDao extends IEntityDao<Users> {

//	 Users searchUserById(String id) ;
//
//	 Users searchUser(String account, String nickName);
//
//	 WriteResult updateUser(Query query, Update update, String string);
//
//	 Users searchUsersByPhone(String mobile);
//	 
//	 public long  searchCount(String userId, String deviceId, String mobile, 
//				String loginname, String channel, Integer scoreStart, Integer scoreEnd, String isBlock,
//				String isMobilebind, String isBind, Integer sysType, Integer status, String version, Date startDate,
//				Date endDate);
	 
	 public List<Users> searchList(String userId, String deviceId, String mobile, 
				String loginname, String channel, Integer scoreStart, Integer scoreEnd, String isBlock,
				String isMobilebind, String isBind, Integer sysType, Integer status, String version, Date startDate,
				Date endDate, int start,
				int	limit);
//
//	List<Users> searchSysUser();
//	 
//	 public Users insertUsersInfo(String name, String loginname, String mobile, String profileImageUrl);
//
//	 public Users updateUsersInfo(String userId, Boolean isBlock, int scoreAdd);

}
