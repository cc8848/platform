package com.xmbl.ops.model.organization;

import java.util.Date;

import lombok.Data;
@Data
public class Resources {

	private Integer id;

    private String name;

    private Integer parentid;

    private String reskey;

    private Integer type;

    private String resurl;

    private Integer level;

    private String description;

    private Byte status;

    private String operator;

    private Date createtime;

    private Date updatetime;

    private Integer pid;

    private ResourcesRole resourcesRole;
    
    private Role role;
    

    private String levelTree;//生成表示树
    
    private boolean hasRole;//对应角色权限有无
  
    
    public Resources(){
    	super();
    }
    
    public Resources(String operator, Integer id, String name, String resUrl, String resKey,
			Integer parentId, Byte status, Integer pid, Integer type, Integer level, String description){
    	this.id = id;
    	this.name = name;
    	this.parentid = parentId;
    	this.reskey = resKey;
    	this.type = type;
    	this.resurl = resUrl;
    	this.level = level;
    	this.description = description;
    	this.status = status;
    	this.createtime = new Date();
    	this.operator = operator;
    	this.pid = pid;
    }
    
    
}