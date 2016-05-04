package com.xmbl.ops.service.game;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.xmbl.ops.dao.game.IGameServerDao;
import com.xmbl.ops.enumeration.EnumGameServerStatus;
import com.xmbl.ops.model.organization.GameServer;

@Service
public class GameServerService {
	
	@Resource
	IGameServerDao gameServerDao;
	
	public long searchCount(Long id, Long serverId, String serverName, Integer status) {
		return gameServerDao.searchCount(id, serverId, serverName, status);
	}
	
	public List<GameServer> searchList(Long id, Long serverId, String serverName, Integer status,
			Long page, int limit) {
		List<GameServer> gameServerList = gameServerDao.searchList(id, serverId,
				serverName, status, page, limit);
        for(GameServer gameServer : gameServerList) {
        	setStatus(gameServer);
        }
		
		return gameServerList;
	}
	
	public List<GameServer> getGameServerList() {
		List<GameServer> gameServerList = gameServerDao.searchGameServerList();
		return gameServerList;
	}
	
	private void setStatus(GameServer gameServer) {
		Byte status = gameServer.getStatus();
    	if( status != null) {
    		for(EnumGameServerStatus Status : EnumGameServerStatus.values()) {
    			if(status.intValue() == Status.getId()) {
    				gameServer.setStatusForStr(Status.getDesc());
    				break;
    			}
    		}
    	}
    }
	
	public GameServer insertGameServer(GameServer gameserver) {
		GameServer gameServer = gameServerDao.addGameServer(gameserver);
		return gameServer;
	}
	
	public GameServer getGameServerById(Long Id) {
		GameServer gameServer = gameServerDao.getById(Id);
		return gameServer;
	}
	
	@Transactional(value = "transactionManager",propagation = Propagation.REQUIRED, isolation = Isolation.READ_COMMITTED, rollbackFor = RuntimeException.class)
	public void auditGameServers(Long[] IdsArray, Integer status, String operatorName) {
		for(Long Id : IdsArray) {
			auditGameServer(Id , status, operatorName);
		}
	}
	
	private synchronized boolean auditGameServer(Long id, Integer status, String operatorName) {
		GameServer gameServer = new GameServer(id, Byte.valueOf(status.toString()) , operatorName);
		gameServerDao.updateIfNecessary(gameServer);
		return true;
	}
	
	public boolean editGameServer(GameServer gameServer) {
		gameServerDao.updateIfNecessary(gameServer);
		return true;
	}
}
