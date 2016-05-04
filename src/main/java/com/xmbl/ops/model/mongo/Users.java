package com.xmbl.ops.model.mongo;

import java.util.Date;

import lombok.Data;
@Data
public class Users {
	private String _id;
	private String name;
	private String mobile;
	private boolean is_mobilebind;
	private String deviceid;
	private boolean is_bind;
	private String loginname;
	private String password;
	private String pass;
	private String email;
	private String reg_type;
	private String url;
	private String profile_image_url;
	private boolean is_block;// 账户锁定
	private Long blocktime;// 锁定时间
	private Integer score;
	private Date create_at;
	private Date update_at;
	private String level;
	// 省份名称和id
	private String edu_province;
	private String edu_city;
	private String edu_area;
	private Integer province_id;
	private Integer city_id;
	private Integer area_id;

	private String edu_school;
	private String edu_grade;
	private String edu_class;
	private Integer sys_type;
	private Integer phone_type;
	private String pushtoken;
	private String push_server;

	private String invited_code;
	private String invite_code;
	private String invite_code_times;
	private String version;
	private String channel;
	private Long collect_tag_count;
	private Long question_count;
	private String token_valid;
	private Long following_count;
	private Long reply_count;
	private String receive_at_mail;
	private Long follower_count;
	private Long collect_topic_count;
	private Long accept_count;
	private Long gender;
	private boolean active;
	private String receive_reply_mail;
	private boolean is_star;
	private Long topic_count;
	
	private String ver_client;
	private Integer vipType;
	
    private Date vip_expire_time;

    
    private String createTimeStr;
    private String isBindStr;
    private String isBlockStr;
    private String isMobilebindStr;
    
}
