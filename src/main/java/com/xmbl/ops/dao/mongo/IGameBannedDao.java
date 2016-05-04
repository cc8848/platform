package com.xmbl.ops.dao.mongo;

import java.util.Date;
import java.util.List;

import com.xmbl.ops.dao.base.IEntityDao;
import com.xmbl.ops.model.mongo.GameBanned;

public interface IGameBannedDao extends IEntityDao<GameBanned> {
	public void insertGameBanned(GameBanned gameBanned);
	
	public List<GameBanned> searchList(Long serverId, Date startDate,
			Date endDate, String userId , String nikeName, Integer type, int start,
			int	limit);
	
	public long searchCount(Long serverId, Date startDate,
			Date endDate, String userId , String nikeName, Integer type);
}
