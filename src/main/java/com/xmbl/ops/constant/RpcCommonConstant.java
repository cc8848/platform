package com.xmbl.ops.constant;

public class RpcCommonConstant {
	public static String ip;
	public static Long port;
	
	public void setRpc_api_url(String ip, Long port) {
		RpcCommonConstant.ip = ip;
		RpcCommonConstant.port = port;
		PLAYERINFO = RpcCommonConstant.ip+":"+RpcCommonConstant.port+"GetPlayerInfo?";//获取玩家角色信息
	}
	public static String PLAYERINFO = null;

}
