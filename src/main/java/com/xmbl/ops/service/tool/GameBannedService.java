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

import com.xmbl.ops.dao.mongo.IGameBannedDao;
import com.xmbl.ops.dto.Server;
import com.xmbl.ops.enumeration.EnumBannedType;
import com.xmbl.ops.model.mongo.GameBanned;
import com.xmbl.ops.util.DateUtils;

@Service
public class GameBannedService {
	private static Logger logger = LoggerFactory.getLogger("banned_log");	
	@Resource
	IGameBannedDao gameBannedDao;
	
	@Autowired
	protected GameServersService gameServersService;
	
	@Transactional(value = "transactionManager",propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = RuntimeException.class)
	public void addGameBanned(Long gameServerId, String userId, String nikeName,
			Integer type, Date startDate, Date endDate, String operatorName) throws Exception {
		GameBanned gameBanned =new GameBanned(gameServerId,userId,nikeName,type,startDate,endDate,operatorName);
		 
		//send 游戏服务器 返回成功插入
		Integer serverId = Integer.valueOf(gameBanned.getIndex().toString());
		if( serverId != null ) {
			Server gameServer = gameServersService.getGameServer(serverId);
			if(gameServer != null) {

			}else{
				logger.error("日期，data={},gameServer={}", DateUtils.formatDate(new Date(), "yyyy-MM-dd hh:mm:ss"),gameServer);
			}
		}

		gameBannedDao.insertGameBanned(gameBanned);
	}
	
	public long searchCount(Long serverId, Date startDate, Date endDate, String userId , String nikeName, Integer type) {
		return gameBannedDao.searchCount(serverId, startDate, endDate, userId, nikeName, type);
	}
	
	public List<GameBanned> searchList(Long serverId, Date startDate,
			Date endDate , String userId, String nikeName, Integer type, int start,
			int	limit) throws Exception {
		List<GameBanned> GameBannedList = gameBannedDao.searchList(serverId, startDate, endDate, userId, nikeName, type, start, limit);
		for(GameBanned gameBanned : GameBannedList) {
			setServerName(gameBanned);
			gameBanned.setStartTimeStr(DateUtils.formatDate(gameBanned.getStart_time()));
			gameBanned.setEndTimeStr(DateUtils.formatDate(gameBanned.getEnd_time()));
			gameBanned.setUpdateTimeStr(DateUtils.formatDate(gameBanned.getUpdate_time()));
			setBannedType(gameBanned);
		}
		
		return GameBannedList;
	}
	private void setBannedType(GameBanned gameBanned) {
		Integer type = gameBanned.getType();
    	if( type != null) {
    		for(EnumBannedType BannedType : EnumBannedType.values()) {
    			if(type.intValue() == BannedType.getId()) {
    				gameBanned.setTypeStr(BannedType.getDesc());
    				break;
    			}
    		}
    	}
    }
	public void setServerName(GameBanned gameBanned) throws Exception {
		Integer serverId = Integer.valueOf(gameBanned.getIndex().toString());
		if( serverId != null ) {
			Server gameServer = gameServersService.getGameServerName(serverId);
			if(gameServer != null) {
				gameBanned.setName(gameServer.getName());
			}else{
				logger.error("日期，data={},gameServer={}", DateUtils.formatDate(new Date(), "yyyy-MM-dd hh:mm:ss"),gameServer);
			}
		}
	}
}
