package com.xmbl.ops.dao.mongo;

import java.util.Date;
import java.util.List;

import com.xmbl.ops.dao.base.IEntityDao;
import com.xmbl.ops.model.mongo.Announcement;

public interface IGameAnnouncementDao extends IEntityDao<Announcement> {
	public void insertAnnouncement(Announcement announcement);
	
	public List<Announcement> searchList(Long serverId, Date startDate,
			Date endDate, String conntent, int start,
			int	limit);
	
	public long searchCount(Long serverId, Date startDate,
			Date endDate, String conntent);
}
