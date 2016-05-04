package com.xmbl.ops.model.mongo;

import java.util.Date;

import lombok.Data;

import org.bson.types.ObjectId;
@Data
public class GameBanned {
	private ObjectId _id;
	private String userId;//玩家id
	private String nikeName;//玩家昵称
	private Long index;//服务器id
	private String name;//服务器名
	private Date start_time;//禁言封号 开始时间
	private Long start_at;
	private Date end_time;//禁言封号 结束时间
	private Long end_at;
	private Integer type;//1:禁言 2:封号   3:取消禁言 4:取消封号
	private Integer status;//发送状态
	private String operator;//操作人
	private Date update_time;
	private Long update_at;
	private String startTimeStr;
	private String endTimeStr;
	private String updateTimeStr;
	private String typeStr;
	
	public GameBanned(){
		super();
	}
	
	public GameBanned(Long index, String userId, String nikeName, Integer type, Date start_time,Date end_time, String operator){
		this.index= index;
		this.userId= nikeName;
		this.start_time= start_time;
		this.start_at= start_time.getTime();
		this.end_time= end_time;
		this.end_at= end_time.getTime();
		this.type = type;
		this.operator= operator;
		this.update_time= new Date();
		this.update_at= System.currentTimeMillis();
	}
	
}
