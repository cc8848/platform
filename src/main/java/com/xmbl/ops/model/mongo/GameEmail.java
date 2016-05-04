package com.xmbl.ops.model.mongo;

import java.util.Date;

import org.bson.types.ObjectId;

import lombok.Data;

@Data
public class GameEmail {
	private ObjectId _id;
	private String content;//邮件内容
	private Long index;//服务器id
	private String name;//服务器名
	private Date create_time;//发送时间
	private Long create_at;
	private Integer status;//发送状态
	private String operator;//操作人
	private Date update_time;
	private Long update_at;
	private String createTimeStr;
	
	public GameEmail(){
		super();
	}
	
	public GameEmail(Long index, String content, Date create_time, String operator){
		this.index= index;
		this.content= content;
		this.create_time= create_time;
		this.create_at= create_time.getTime();
		this.operator= operator;
		this.update_time= new Date();
		this.update_at= System.currentTimeMillis();
	}
}
