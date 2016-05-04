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

import com.xmbl.ops.dao.mongo.IGameEmailDao;
import com.xmbl.ops.dto.Server;
import com.xmbl.ops.model.mongo.GameEmail;
import com.xmbl.ops.util.DateUtils;

@Service
public class GameEmailService {
	private static Logger logger = LoggerFactory.getLogger("email_log");	
	@Resource
	IGameEmailDao gameEmailDao;
	
	@Autowired
	protected GameServersService gameServersService;
	
	@Transactional(value = "transactionManager",propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = RuntimeException.class)
	public void addGameEmail(Long[]  ServerIdsArray, String content, Date startDate, String operatorName) throws Exception{
		for(Long Id : ServerIdsArray) {
			insertGameEmail(Id, content, startDate, operatorName);
		}
	}
	
	public void insertGameEmail(Long Id, String content, Date startDate, String operatorName) throws Exception {
		GameEmail gameEmail =new GameEmail(Id, content, startDate, operatorName);
		 
		 //send 游戏服务器 返回成功插入
		 Integer serverId = Integer.valueOf(gameEmail.getIndex().toString());
			if( serverId != null ) {
				Server gameServer = gameServersService.getGameServer(serverId);
				if(gameServer != null) {
					
				}else{
					logger.error("日期，data={},gameServer={}", DateUtils.formatDate(new Date(), "yyyy-MM-dd hh:mm:ss"),gameServer);
				}
		}
		 
			gameEmailDao.insertGameEmail(gameEmail);
	}
	
	public long searchCount(Long serverId, Date startDate, Date endDate, String content) {
		return gameEmailDao.searchCount(serverId, startDate, endDate, content);
	}
	
	public List<GameEmail> searchList(Long serverId, Date startDate,
			Date endDate , String content, int start,
			int	limit) throws Exception {
		List<GameEmail> GameEmailList = gameEmailDao.searchList(serverId, startDate, endDate, content, start, limit);
		for(GameEmail gameEmail : GameEmailList) {
			setServerName(gameEmail);
			gameEmail.setCreateTimeStr(DateUtils.formatDate(gameEmail.getCreate_time()));
		}
		
		return GameEmailList;
	}
	
	public void setServerName(GameEmail gameEmail) throws Exception {
		Integer serverId = Integer.valueOf(gameEmail.getIndex().toString());
		if( serverId != null ) {
			Server gameServer = gameServersService.getGameServerName(serverId);
			if(gameServer != null) {
				gameEmail.setName(gameServer.getName());
			}else{
				logger.error("日期，data={},gameServer={}", DateUtils.formatDate(new Date(), "yyyy-MM-dd hh:mm:ss"),gameServer);
			}
		}
	}
}
