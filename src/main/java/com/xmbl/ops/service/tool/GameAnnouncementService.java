package com.xmbl.ops.service.tool;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.xmbl.ops.dao.mongo.IGameAnnouncementDao;
import com.xmbl.ops.dto.Server;
import com.xmbl.ops.model.mongo.Announcement;
import com.xmbl.ops.util.DateUtils;

@Service
public class GameAnnouncementService {
	private static Logger logger = LoggerFactory.getLogger("announcement_log");	
	@Resource
	IGameAnnouncementDao gameAnnouncementDao;
	
	@Autowired
	protected GameServersService gameServersService;
	
	@Transactional(value = "transactionManager",propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = RuntimeException.class)
	public void addGameAnnouncement(Long[]  ServerIdsArray, String content, Date startDate, String operatorName) throws Exception{
		for(Long Id : ServerIdsArray) {
			insertGameAnnouncement(Id, content, startDate, operatorName);
		}
	}
	
	public void insertGameAnnouncement(Long Id, String content, Date startDate, String operatorName) throws Exception {
		 Announcement announcement =new Announcement(Id, content, startDate, operatorName);
		 
		 //send 游戏服务器 返回成功插入
		 Integer serverId = Integer.valueOf(announcement.getIndex().toString());
			if( serverId != null ) {
				Server gameServer = gameServersService.getGameServer(serverId);
				if(gameServer != null) {
					
				}else{
					logger.error("日期，data={},gameServer={}", DateUtils.formatDate(new Date(), "yyyy-MM-dd hh:mm:ss"),gameServer);
				}
		}
		 
		 gameAnnouncementDao.insertAnnouncement(announcement);
	}
	
	public long searchCount(Long serverId, Date startDate, Date endDate, String content) {
		return gameAnnouncementDao.searchCount(serverId, startDate, endDate, content);
	}
	
	public List<Announcement> searchList(Long serverId, Date startDate,
			Date endDate , String content, int start,
			int	limit) throws Exception {
		List<Announcement> AnnouncementList = gameAnnouncementDao.searchList(serverId, startDate, endDate, content, start, limit);
		for(Announcement announcement : AnnouncementList) {
			setServerName(announcement);
			announcement.setCreateTimeStr(DateUtils.formatDate(announcement.getCreate_time()));
		}
		
		return AnnouncementList;
	}
	
	public void setServerName(Announcement announcement) throws Exception {
		Integer serverId = Integer.valueOf(announcement.getIndex().toString());
		if( serverId != null ) {
			Server gameServer = gameServersService.getGameServerName(serverId);
			if(gameServer != null) {
				announcement.setName(gameServer.getName());
			}else{
				logger.error("日期，data={},gameServer={}", DateUtils.formatDate(new Date(), "yyyy-MM-dd hh:mm:ss"),gameServer);
			}
		}
	}
}
