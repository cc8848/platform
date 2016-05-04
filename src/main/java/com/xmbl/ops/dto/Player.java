package com.xmbl.ops.dto;

import lombok.Data;

@Data
public class Player {
	
	private Long paleyId;
	
	private String playName;
	
	private Long id; // 角色ID
	private String name;//角色名称
	private Integer clazz;//角色职业
	private Integer sex; //角色性别
	private Integer accountId; //账号ID
	private Integer serverId; //服务器ID
	private Integer isDeleted; //角色删除标示
	private Boolean isNew;    //角色新建标示
	
	//这些数据会变化，需要更新
	private Integer fightingForce; //角色战斗力
	private Integer level;         //角色等级
	private Integer rebirthLevel;  //角色转生等级
	private Integer sceneId;       //所在场景
	private Integer militaryRank;  //军衔
	private Integer achievementLevel; //成就等级
	private Boolean online;        //在线标示
	private String activePetName;   //当前宠物名称
	
	public Player() {
		super();
	}
	public Player(Long paleyId, String playName) {
		this.paleyId = paleyId;
		this.playName = playName;
	}
	
	public Player( Long id,  String name,Integer clazz,Integer sex, Integer accountId, Integer serverId,
	 Integer isDeleted, Boolean isNew) {
		this.id = id;
		this.name = name;
		this.name = name;
		this.sex = sex;
		this.accountId = accountId;
		this.serverId = serverId;
		this.isDeleted = isDeleted;
		this.isNew = isNew;
	}
	
	
}
