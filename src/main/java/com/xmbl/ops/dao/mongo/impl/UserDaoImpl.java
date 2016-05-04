package com.xmbl.ops.dao.mongo.impl;

import java.net.UnknownHostException;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.bson.types.ObjectId;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.mongodb.BasicDBObject;
import com.mongodb.DB;
import com.mongodb.DBCollection;
import com.mongodb.DBCursor;
import com.mongodb.DBObject;
import com.mongodb.MapReduceOutput;
import com.mongodb.MongoClient;
import com.mongodb.WriteResult;
import com.xmbl.ops.dao.mongo.IUserDao;
import com.xmbl.ops.model.mongo.Users;
//import com.xmbl.ops.dao.base.EntityMongoDaoImpl;

@Repository
//public class UserDaoImpl extends EntityMongoDaoImpl<Users> implements IUserDao{
public class UserDaoImpl {
	public List<Users> searchList(String userId, String deviceId, String mobile, 
	String loginname, String channel, Integer scoreStart, Integer scoreEnd, String isBlock,
	String isMobilebind, String isBind, Integer sysType, Integer status, String version, Date startDate,
	Date endDate, int start,
	int	limit) {
		try{
			MongoClient mongoClient = null;
			String dburl = null,database = null,username = null,password = null;
			Integer port = null;
			try {
				mongoClient = new MongoClient(dburl, port);
				DB db = mongoClient.getDB(database);
				boolean auth = db.authenticate(username, password.toCharArray());
				DBObject cmd1 = new BasicDBObject();
				cmd1.put("aggregate", "users");
				cmd1.put("pipeline", Arrays.asList(new BasicDBObject("$match", new BasicDBObject("version", 11).append("phone_type", 1).append("mobile", new BasicDBObject("$ne", null))),
						new BasicDBObject("$group", new BasicDBObject("_id", "$deviceid"))
						));
				cmd1.put("allowDiskUse", true);
				DBCollection dbc = db.getCollection("users");
				String mapfun = "function() {" +
						"emit({deviceid:this.deviceid}, 1);" +
						"}";
				String reducefun = " function(key,vals){var count=0; for(var i in vals){count+=vals[i];} return count;}";
				DBObject query =null;
				query = new BasicDBObject("version",11).
						append("phone_type", 1).
						append("mobile", new BasicDBObject("$ne", null))
						.append("deviceid", new BasicDBObject("$ne", null));
				long old = System.currentTimeMillis();
				//在dbcollection上执行mapreduce
				MapReduceOutput mro = dbc.mapReduce(mapfun, reducefun,
						"tem_distinct_Android", query);
				long now = System.currentTimeMillis();
				long totalUserDev = mro.getOutputCollection().count();
				if(mro.getOutputCollection().count()>0){
					BasicDBObject keys = new BasicDBObject();
					keys.put("_id", 1);
					BasicDBObject condition=new BasicDBObject();//条件			
					DBCursor cursor=mro.getOutputCollection().find(condition, keys);
					//把结果集输出成list类型
					List<DBObject> listArray =  cursor.toArray();
					if(listArray.size()>0){
						LinkedBlockingDeque<DBObject> list = new LinkedBlockingDeque<DBObject>();
						for(DBObject obj : listArray) {
							list.add(obj);
						}	
					}	        	
				}
				//删除临时表
				mro.getOutputCollection().drop();
			} catch (UnknownHostException e) {
				e.printStackTrace();
			} finally {
				if(mongoClient != null) { mongoClient.close(); }
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	return null;
//	return getMongoTemplate().find(query, Users.class, "users");
}

//	public Users searchUserById(String id) {
//		Criteria criteria = new Criteria();
//		if (StringUtils.isNotEmpty(id))
//			criteria = criteria.and("_id").is(new ObjectId(id));
//		Query query = new Query();
//		query.addCriteria(criteria);
//		return getMongoTemplate().findOne(query, Users.class, "users");
//	}
//
//	@Override
//	public Users searchUser(String account, String nickName) {
//		Query query = new Query();
//        if(StringUtils.isNotEmpty(account)) {
//        	Criteria criteria = Criteria.where("mobile").is(account);
//			query.addCriteria(criteria);
//        }
//        if(StringUtils.isNotEmpty(nickName)) {
//        	Criteria criteria = Criteria.where("loginname").is(nickName);
//			query.addCriteria(criteria); 
//        }
//        return getMongoTemplate().findOne(query, Users.class, "users");
//	}
//
//	@Override
//	public WriteResult updateUser(Query query, Update update, String string) {
//		return getMongoTemplate().updateFirst(query, update, string);
//	}
//
//	@Override
//	public Users searchUsersByPhone(String mobile) {
//		Criteria criteria = Criteria.where("mobile").is(mobile);
//		Query query = new Query();
//		query.addCriteria(criteria);
//		query.limit(1);
//		return getMongoTemplate().findOne(query, Users.class, "users");
//	}
//	
//	
//	public long searchCount(String userId, String deviceId, String mobile, 
//			String loginname, String channel, Integer scoreStart, Integer scoreEnd, String isBlock,
//			String isMobilebind, String isBind, Integer sysType, Integer status, String version, Date startDate,
//			Date endDate) {
//		Query query = new Query();
//		Criteria criteria = new Criteria();
//		// 用户类型
//		if (null != sysType)
//			criteria = criteria.and("sys_type").is(sysType);
//		// userId
//		if (null != userId && StringUtils.isNotEmpty(userId))
//			criteria = criteria.and("_id").is(new ObjectId(userId));
//		// 设备号，为1的时候查询设备号为空的
//		if (null != deviceId && !"".equals(deviceId) && !"1".equals(deviceId)) {
//			criteria = criteria.and("deviceid").is(deviceId);
//		} else if (null != deviceId && "1".equals(deviceId)) {
//			criteria = criteria.and("deviceid").is("");
//		}
//		// 手机号
//		if (null != mobile && !"".equals(mobile))
//			criteria = criteria.and("mobile").is(mobile);
//
//		// 手机绑定状态
//		if (null != isMobilebind && !"".equals(isMobilebind)) {
//			if ("true".equals(isMobilebind))
//				criteria = criteria.and("is_mobilebind").is(true);
//			else
//				criteria = criteria.and("is_mobilebind").is(false);
//		}
//		// 时间段
//		if (null != startDate && !"".equals(startDate) && null != endDate
//				&& !"".equals(endDate)) {
//			criteria = criteria.andOperator(Criteria.where("create_at")
//					.gte(startDate).lte(endDate));
//		}
//
//		if (null != loginname && !"".equals(loginname)) {
//			// 模糊查询：查询字符串里带findStr的： Pattern pattern = Pattern.compile("^.*" +
//			// findStr + ".*$", Pattern.CASE_INSENSITIVE);
//			// ^.*王.*$ MULTILINE Pattern pattern = Pattern.compile("^.*" +
//			// findStr + ".*$", Pattern.MULTILINE);
//			// Pattern pattern = Pattern.compile(".*" + content+ ".$"+ content+
//			// "%' " ,Pattern.CASE_INSENSITIVE);
//			// criteria = criteria.and("content").regex(pattern.toString());
//			Pattern pattern = Pattern.compile("^.*" + loginname + ".*$",
//					Pattern.MULTILINE);
//			criteria = criteria.and("loginname").regex(pattern);
//		}
//		// 查询用户积分范围
//		if (null != scoreStart && !"".equals(scoreStart) && null != scoreEnd
//				&& !"".equals(scoreEnd))// 如果积分区间完整
//			criteria = criteria.and("score").gte(scoreStart).lte(scoreEnd);// 大于等于
//		else if (null != scoreStart && !"".equals(scoreStart)
//				&& null == scoreEnd)// 如果只有开始积分
//			criteria = criteria.and("score").gte(scoreStart);
//		else if (null == scoreStart && null != scoreEnd)// 如果只有截止积分
//			criteria = criteria.and("score").lte(scoreEnd);
//		// 是否查询被封账户
//		if (null != isBlock && !"".equals(isBlock)) {
//			if ("true".equals(isBlock))
//				criteria = criteria.and("is_block").is(true);
//			else
//				criteria = criteria.and("is_block").is(false);
//		}
//		
//		if (null != channel && !"".equals(channel))
//			criteria = criteria.and("channel").regex(channel);
//		
//		
//		query.addCriteria(criteria);
//		return getMongoTemplate().count(query, "users");
//	}
//	
//	public List<Users> searchList(String userId, String deviceId, String mobile, 
//			String loginname, String channel, Integer scoreStart, Integer scoreEnd, String isBlock,
//			String isMobilebind, String isBind, Integer sysType, Integer status, String version, Date startDate,
//			Date endDate, int start,
//			int	limit) {
//			Query query = new Query();
//			Criteria criteria = new Criteria();
//			// 用户类型
//			if (null != sysType)
//				criteria = criteria.and("sys_type").is(sysType);
//			// userId
//			if (null != userId && StringUtils.isNotEmpty(userId))
//				criteria = criteria.and("_id").is(new ObjectId(userId));
//			// 设备号，为1的时候查询设备号为空的
//			if (null != deviceId && !"".equals(deviceId) && !"1".equals(deviceId)) {
//				criteria = criteria.and("deviceid").is(deviceId);
//			} else if (null != deviceId && "1".equals(deviceId)) {
//				criteria = criteria.and("deviceid").is("");
//			}
//			// 手机号
//			if (null != mobile && !"".equals(mobile))
//				criteria = criteria.and("mobile").is(mobile);
//
//			// 手机绑定状态
//			if (null != isMobilebind && !"".equals(isMobilebind)) {
//				if ("true".equals(isMobilebind))
//					criteria = criteria.and("is_mobilebind").is(true);
//				else
//					criteria = criteria.and("is_mobilebind").is(false);
//			}
//			// 时间段
//			if (null != startDate && !"".equals(startDate) && null != endDate
//					&& !"".equals(endDate)) {
//				criteria = criteria.andOperator(Criteria.where("create_at")
//						.gte(startDate).lte(endDate));
//			}
//
//			if (null != loginname && !"".equals(loginname)) {
//				// 模糊查询：查询字符串里带findStr的： Pattern pattern = Pattern.compile("^.*" +
//				// findStr + ".*$", Pattern.CASE_INSENSITIVE);
//				// ^.*王.*$ MULTILINE Pattern pattern = Pattern.compile("^.*" +
//				// findStr + ".*$", Pattern.MULTILINE);
//				// Pattern pattern = Pattern.compile(".*" + content+ ".$"+ content+
//				// "%' " ,Pattern.CASE_INSENSITIVE);
//				// criteria = criteria.and("content").regex(pattern.toString());
//				Pattern pattern = Pattern.compile("^.*" + loginname + ".*$",
//						Pattern.MULTILINE);
//				criteria = criteria.and("loginname").regex(pattern);
//			}
//			// 查询用户积分范围
//			if (null != scoreStart && !"".equals(scoreStart) && null != scoreEnd
//					&& !"".equals(scoreEnd))// 如果积分区间完整
//				criteria = criteria.and("score").gte(scoreStart).lte(scoreEnd);// 大于等于
//			else if (null != scoreStart && !"".equals(scoreStart)
//					&& null == scoreEnd)// 如果只有开始积分
//				criteria = criteria.and("score").gte(scoreStart);
//			else if (null == scoreStart && null != scoreEnd)// 如果只有截止积分
//				criteria = criteria.and("score").lte(scoreEnd);
//			// 是否查询被封账户
//			if (null != isBlock && !"".equals(isBlock)) {
//				if ("true".equals(isBlock))
//					criteria = criteria.and("is_block").is(true);
//				else
//					criteria = criteria.and("is_block").is(false);
//			}
//			
//			if (null != channel && !"".equals(channel))
//				criteria = criteria.and("channel").regex(channel);
//			
//			
//			query.addCriteria(criteria);
//			query.with(new Sort(Sort.Direction.DESC, "create_at"));
//			query.skip(start);
//			query.limit(limit);
//			return getMongoTemplate().find(query, Users.class, "users");
//		}
//
//	@Override
//	public List<Users> searchSysUser() {
//		Query query = new Query();
//		Criteria criteria = Criteria.where("sys_type").is(1); // 运营账号
//        query.addCriteria(criteria);
//        query.with(new Sort(Sort.Direction.ASC, "loginname"));
//		return getMongoTemplate().find(query, Users.class, "users");
//	}
//
//	
//	public Users insertUsersInfo(String name, String loginname, String mobile, String profileImageUrl) {
//		Users usersInfo = new Users();
//		usersInfo.setName(name);
//		usersInfo.setLoginname(loginname);
//		usersInfo.setMobile(mobile);
//		usersInfo.setProfile_image_url(profileImageUrl);
//		usersInfo.set_bind(true);
//		usersInfo.set_mobilebind(true);
//		usersInfo.set_block(false);
//		usersInfo.setSys_type(1);
//		usersInfo.setReg_type("sys");
//		usersInfo.setPassword(null);
//		usersInfo.setDeviceid(String.valueOf(0));
//		usersInfo.setCreate_at(new Date());
//		usersInfo.setUpdate_at(new Date());
//		
//		getMongoTemplate().insert(usersInfo, "users");
//		return usersInfo;
//	}
//	
//	public Users updateUsersInfo(String userId, Boolean isBlock, int scoreAdd) {
//		Users usersInfo = new Users();
//		Update update = new Update();
//		update.set("score",Integer.valueOf(scoreAdd));
//		update.set("is_block",isBlock);
//		if(isBlock){
//			update.set("is_mobilebind",false);
//		}else {
//			update.set("is_mobilebind",true);
//		}
//		update.set("blocktime",0);
//		WriteResult writeResult = getMongoTemplate().updateFirst(Query.query(Criteria.where("_id").is(new ObjectId(userId))), update, "users");
//		if( StringUtils.isEmpty(writeResult.getError())){
//			usersInfo = getMongoTemplate().findOne(Query.query(Criteria.where("_id").is(new ObjectId(userId))), Users.class, "users");
//		}
//		return usersInfo;
//	}
	
}
