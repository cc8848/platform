package com.xmbl.ops.dto;

import lombok.Data;

@Data
public class Server {

	private Long id;
	
	private Long index;
	
	private String name;
	
	private String ip;
	
	private Long prot;
	
	private String state;
	
	private String rpcIp;
	
	private Long rpcPort;
	
	public Server() {
		super();
	}
}
