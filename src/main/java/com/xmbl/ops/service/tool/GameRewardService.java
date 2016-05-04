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

import com.xmbl.ops.dao.mongo.IGameRewardDao;
import com.xmbl.ops.dto.Server;
import com.xmbl.ops.model.mongo.GameReward;
import com.xmbl.ops.util.DateUtils;

@Service
public class GameRewardService {
	private static Logger logger = LoggerFactory.getLogger("reward_log");	
	@Resource
	IGameRewardDao gameRewardDao;
	
	@Autowired
	protected GameServersService gameServersService;
	
	@Transactional(value = "transactionManager",propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = RuntimeException.class)
	public void addGameReward(Long[]  ServerIdsArray, String content, Date startDate, String operatorName) throws Exception{
		for(Long Id : ServerIdsArray) {
			insertGameReward(Id, content, startDate, operatorName);
		}
	}
	
	public void insertGameReward(Long Id, String content, Date startDate, String operatorName) throws Exception {
		GameReward gameReward =new GameReward();
		 
		 //send 游戏服务器 返回成功插入
		 Integer serverId = Integer.valueOf(gameReward.getIndex().toString());
			if( serverId != null ) {
				Server gameServer = gameServersService.getGameServer(serverId);
				if(gameServer != null) {
					
				}else{
					logger.error("日期，data={},gameServer={}", DateUtils.formatDate(new Date(), "yyyy-MM-dd hh:mm:ss"),gameServer);
				}
		}
		 
			gameRewardDao.insertGameReward(gameReward);
	}
	
	public long searchCount(Long serverId, Date startDate, Date endDate, String content) {
		return gameRewardDao.searchCount(serverId, startDate, endDate, content);
	}
	
	public List<GameReward> searchList(Long serverId, Date startDate,
			Date endDate , String content, int start,
			int	limit) throws Exception {
		List<GameReward> GameRewardList = gameRewardDao.searchList(serverId, startDate, endDate, content, start, limit);
		for(GameReward gameReward : GameRewardList) {
			setServerName(gameReward);
			gameReward.setCreateTimeStr(DateUtils.formatDate(gameReward.getCreate_time()));
		}
		
		return GameRewardList;
	}
	
	public void setServerName(GameReward gameReward) throws Exception {
		Integer serverId = Integer.valueOf(gameReward.getIndex().toString());
		if( serverId != null ) {
			Server gameServer = gameServersService.getGameServerName(serverId);
			if(gameServer != null) {
				gameReward.setName(gameServer.getName());
			}else{
				logger.error("日期，data={},gameServer={}", DateUtils.formatDate(new Date(), "yyyy-MM-dd hh:mm:ss"),gameServer);
			}
		}
	}
}
