package com.xmbl.ops.dao.mongo;

import java.util.Date;
import java.util.List;

import com.xmbl.ops.dao.base.IEntityDao;
import com.xmbl.ops.model.mongo.GameEmail;

public interface IGameEmailDao extends IEntityDao<GameEmail> {
	public void insertGameEmail(GameEmail gameEmail);
	
	public List<GameEmail> searchList(Long serverId, Date startDate,
			Date endDate, String conntent, int start,
			int	limit);
	
	public long searchCount(Long serverId, Date startDate,
			Date endDate, String conntent);
}
