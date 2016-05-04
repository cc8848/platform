package com.xmbl.ops.dao.organization;

import java.util.Date;
import java.util.List;

import com.xmbl.ops.dao.base.IEntityDao;
import com.xmbl.ops.model.organization.UserLog;


public interface IUserLogDao extends IEntityDao<UserLog>{

	long searchCount(String username, Date startDate, Date endDate);

	List<UserLog> searchList(String username, Date startDate, Date endDate, Long page, int limit);
	
	public UserLog addUserLog(UserLog userLog);
	
	public int updateUserLog(UserLog userLog);
	
}
