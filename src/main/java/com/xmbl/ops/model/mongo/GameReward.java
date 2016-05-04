package com.xmbl.ops.model.mongo;

import java.util.Date;

import lombok.Data;

import org.bson.types.ObjectId;
@Data
public class GameReward {
	private ObjectId _id;
	private String userId;//玩家id
	private String nikeName;//玩家昵称
	private Long index;//服务器id
	private String name;//服务器名
	private Date create_time;//执行时间
	private Long create_at;
	private Integer type;//奖励类型
	private Integer itemId;//物品id
	private Integer num;//数量
	private Integer status;//发送状态
	private String operator;//操作人
	private Date update_time;
	private Long update_at;
	private String createTimeStr;
	private String startTimeStr;
	private String endTimeStr;
	private String typeStr;
	private String itemName;
	
	public GameReward(){
		super();
	}
	
	public GameReward(Long index, String userId, String nikeName, Integer type, Integer itemId, Integer num, Date create_time, String operator){
		this.index= index;
		this.userId= nikeName;
		this.create_time= create_time;
		this.create_at= create_time.getTime();
		this.type = type;
		this.itemId = itemId;
		this.num = num;
		this.operator= operator;
		this.update_time= new Date();
		this.update_at= System.currentTimeMillis();
	}
}
