package com.xmbl.ops.model.mongo;

import java.util.Date;

import lombok.Data;

import org.bson.types.ObjectId;
@Data
public class GameCdkey {
	private ObjectId _id;
	private Long index;//服务器id
	private String name;//服务器名
	private String cdkey;//cdkey--(活动批次号)
	private String cdkeyName;//活动描述
	private Date start_time;//活动 开始时间
	private Long start_at;
	private Date end_time;//活动 结束时间
	private Long end_at;
	private String rewardItem;//奖励物品---{物品类型，物品id，物品数量；物品类型，物品id，物品数量}
	private Date create_time;//创建时间
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
	
	public GameCdkey(){
		super();
	}
	
	public GameCdkey(Long index, String cdkey, String cdkeyName, String rewardItem, Date start_time, Date end_time, String operator){
		this.index= index;
		this.cdkey= cdkey;
		this.cdkeyName= cdkeyName;
		this.rewardItem= rewardItem;
		this.start_time= start_time;
		this.start_at= start_time.getTime();
		this.end_time= end_time;
		this.end_at= end_time.getTime();
		this.operator= operator;
		this.create_time= new Date();
		this.create_at= new Date().getTime();
		this.update_time= new Date();
		this.update_at= System.currentTimeMillis();
	}
}
