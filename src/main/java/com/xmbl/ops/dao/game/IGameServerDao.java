package com.xmbl.ops.dao.game;
import java.util.List;

import com.xmbl.ops.dao.base.IEntityDao;
import com.xmbl.ops.model.organization.GameServer;

public interface IGameServerDao extends IEntityDao<GameServer>{
	
	long searchCount(Long id, Long serverId, String serverName, Integer status);
	
	List<GameServer> searchList(Long id, Long serverId, String serverName, Integer status,
			Long page, int limit);

	List<GameServer> searchGameServerList();
	
	public GameServer addGameServer(GameServer gameserver);
	
	public int updateGameServer(GameServer gameserver);
}
