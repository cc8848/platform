package com.xmbl.ops.dao.game.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xmbl.ops.dao.base.EntityDaoMPDBImpl;
import com.xmbl.ops.dao.game.IGameServerDao;
import com.xmbl.ops.model.organization.GameServer;
@Repository
public class GameServerDaoImpl extends EntityDaoMPDBImpl<GameServer> implements IGameServerDao{
	@Override
	public long searchCount(Long id, Long serverId, String serverName, Integer status) {
		Map<String, Object> para = new HashMap<String, Object>();
		para.put("id", id);
		para.put("serverId", serverId);
		para.put("serverName", serverName);
		para.put("status", status);
		long count = getSqlSessionTemplate().selectOne(getNameSpace() + ".searchCount", para);
		return count;
	}
	@Override
	public List<GameServer> searchList(Long id, Long serverId, String serverName, Integer status,
			Long page, int limit) {
		Map<String, Object> para = new HashMap<String, Object>();
		para.put("offset", page);
		para.put("limit", limit);
		para.put("id", id);
		para.put("serverId", serverId);
		para.put("serverName", serverName);
		para.put("status", status);
		List<GameServer> results = getSqlSessionTemplate().selectList(getNameSpace() + ".searchList", para);
		return results;
	}
	@Override
	public List<GameServer> searchGameServerList() {
		Map<String, Object> para = new HashMap<String, Object>();
		List<GameServer> results = getSqlSessionTemplate().selectList(getNameSpace() + ".searchGameServerList", para);
		return results;
	}
	
	@Override
	public GameServer addGameServer(GameServer gameserver) {
		GameServer gameservers=insertSelective(gameserver);
		return gameservers;
	}
	@Override
	public int updateGameServer(GameServer gameserver) {
		int count=updateIfNecessary(gameserver);
		return count;
	}
}
