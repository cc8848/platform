package com.xmbl.ops.service.tool;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import com.xmbl.ops.dto.Server;

@Service
public class GameServersService {
	@Autowired
	protected StringRedisTemplate redisTemplate;

	private static String redisGameServerKey = "ServerLists";
	public List<Server> getGameServerList() throws Exception {
		String wordlist = redisTemplate.opsForValue().get(redisGameServerKey);
		List<Server> gameServerList = new ArrayList<Server>();
		if(StringUtils.isNotEmpty(wordlist)) {
			Document doc = DocumentHelper.parseText(wordlist);
			Element nodesElement = doc.getRootElement();
			List nodes = nodesElement.elements();
			for (Iterator<?> it = nodes.iterator(); it.hasNext();) {  
				Element e = (Element) it.next();  
				Server server = new Server();
				if(e.attributeValue("type").toString().equals("World")) {
					Integer id =Integer.valueOf(e.attributeValue("id"));
					if( id != null) {
						server.setId(Long.valueOf(id));
					}
					Integer idGen =Integer.valueOf(e.attributeValue("idGen"));
					if( idGen != null) {
						server.setIndex(Long.valueOf(idGen));
					}
					String name =e.attributeValue("name");
					if( id != null) {
						server.setName(name);
					}
					gameServerList.add(server);
				}
			}  
		}
		return gameServerList;
	}
	/**
	 * 业务--获取战斗服务器列表
	 * @return serverListJson -- 战斗服务器列表json
	 * @throws Exception
	 */
	public List<Map<String, Object>> getWorldServerList() throws Exception {
		String wordlist = redisTemplate.opsForValue().get(redisGameServerKey);
		List<Map<String, Object>> serverListJson = new ArrayList<Map<String, Object>>();
		if(StringUtils.isNotEmpty(wordlist)) {
			Document doc = DocumentHelper.parseText(wordlist);
			Element nodesElement = doc.getRootElement();
			List nodes = nodesElement.elements();
			for (Iterator<?> it = nodes.iterator(); it.hasNext();) {  
				Element e = (Element) it.next();  
				Map<String, Object> serverJson = new HashMap<String, Object>();
				if(e.attributeValue("type").toString().equals("World")) {
					serverJson.put("id", e.attributeValue("id"));
					serverJson.put("index", e.attributeValue("idGen"));
					serverJson.put("name", e.attributeValue("name"));
					serverJson.put("ip", e.attributeValue("frontEndIp"));
					serverJson.put("port", e.attributeValue("frontEndPort"));
					serverJson.put("state", e.attributeValue("state"));
					System.out.println(serverJson.toString());
					serverListJson.add(serverJson);
				}
			}  
		}
		return serverListJson;
	}
	
	/**
	 * 通过服务器区id, idGen 获取游戏服务器 rpcip,prot  进行发送消息
	 * 
	 */
	public Server getGameServer(Integer serverId) throws Exception {
		String wordlist = redisTemplate.opsForValue().get(redisGameServerKey);
		Server gameServer = new Server();
		if(StringUtils.isNotEmpty(wordlist)) {
			Document doc = DocumentHelper.parseText(wordlist);
			Element nodesElement = doc.getRootElement();
			List nodes = nodesElement.elements();
			for (Iterator<?> it = nodes.iterator(); it.hasNext();) {  
				Element e = (Element) it.next();  
				if(e.attributeValue("idGen").toString().equals(serverId.toString())) {
					gameServer.setIndex(Long.valueOf(e.attributeValue("idGen")));
					gameServer.setRpcIp(e.attributeValue("rpcIp"));
					gameServer.setRpcPort(Long.valueOf(e.attributeValue("rpcPort")));
					break;
				}
			}  
		}
		return gameServer;
	}
	
	
	/**
	 * 通过服务器区id, idGen 获取游戏服务器 rpcip,prot  进行发送消息
	 * 
	 */
	public Server getGameServerName(Integer serverId) throws Exception {
		String wordlist = redisTemplate.opsForValue().get(redisGameServerKey);
		Server gameServer = new Server();
		if(StringUtils.isNotEmpty(wordlist)) {
			Document doc = DocumentHelper.parseText(wordlist);
			Element nodesElement = doc.getRootElement();
			List nodes = nodesElement.elements();
			for (Iterator<?> it = nodes.iterator(); it.hasNext();) {  
				Element e = (Element) it.next();  
				if(e.attributeValue("idGen").toString().equals(serverId.toString())) {
					gameServer.setIndex(Long.valueOf(e.attributeValue("idGen")));
					gameServer.setName(e.attributeValue("name"));
					break;
				}
			}  
		}
		return gameServer;
	}
}
