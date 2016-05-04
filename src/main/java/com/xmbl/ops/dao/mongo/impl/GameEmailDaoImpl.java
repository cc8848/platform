package com.xmbl.ops.dao.mongo.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.xmbl.ops.dao.base.EntityMongoDaoImpl;
import com.xmbl.ops.dao.mongo.IGameEmailDao;
import com.xmbl.ops.model.mongo.GameEmail;

@Repository
public class GameEmailDaoImpl extends EntityMongoDaoImpl<GameEmail> implements IGameEmailDao{

	public void insertGameEmail(GameEmail gameEmail){
		 getMongoTemplate().insert(gameEmail, "email");
	}
	public long searchCount(Long serverId, Date startDate,
			Date endDate , String conntent) {
		Query query = new Query();
		Criteria criteria = new Criteria();
		if (null != serverId && !"".equals(serverId) && null != serverId
				&& !"".equals(serverId)){
			criteria = criteria.and("index").is(serverId);
		}
        if(StringUtils.isNotEmpty(conntent)) {
            criteria = criteria.and("conntent").is(conntent);
			query.addCriteria(criteria);
        }
        // 时间段
        if (null != startDate && !"".equals(startDate) && null != endDate
        		&& !"".equals(endDate)) {
        	criteria = criteria.andOperator(Criteria.where("create_at")
        			.gte(startDate).lte(endDate));
        }
		query.addCriteria(criteria);
		return getMongoTemplate().count(query, "email");
	}
	
	@Override
	public List<GameEmail> searchList(Long serverId, Date startDate,
			Date endDate , String conntent, int start,
			int	limit) {
		Query query = new Query();
		Criteria criteria = new Criteria();
		if (null != serverId && !"".equals(serverId) && null != serverId
				&& !"".equals(serverId)){
			criteria = criteria.and("index").is(serverId);
		}
        if(StringUtils.isNotEmpty(conntent)) {
            criteria = criteria.and("conntent").is(conntent);
			query.addCriteria(criteria);
        }
        // 时间段
        if (null != startDate && !"".equals(startDate) && null != endDate
        		&& !"".equals(endDate)) {
        	criteria = criteria.andOperator(Criteria.where("create_at")
        			.gte(startDate).lte(endDate));
        }
        query.addCriteria(criteria);
        query.with(new Sort(Sort.Direction.DESC, "create_at"));
        query.skip(start);
        query.limit(limit);
        return getMongoTemplate().find(query, GameEmail.class, "email");
	}
}
