package com.xmbl.ops.dao.mongo.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Sort;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Repository;

import com.xmbl.ops.dao.base.EntityMongoDaoImpl;
import com.xmbl.ops.dao.mongo.IGameBannedDao;
import com.xmbl.ops.model.mongo.GameBanned;

@Repository
public class GameBannedDaoImpl extends EntityMongoDaoImpl<GameBanned> implements IGameBannedDao{

	public void insertGameBanned(GameBanned gameBanned){
		 getMongoTemplate().insert(gameBanned, "banned");
	}
	public long searchCount(Long serverId, Date startDate,
			Date endDate , String userId , String nikeName, Integer type) {
		Query query = new Query();
		Criteria criteria = new Criteria();
		if (null != serverId && !"".equals(serverId) && null != serverId
				&& !"".equals(serverId)){
			criteria = criteria.and("index").is(serverId);
		}
        if(StringUtils.isNotEmpty(userId)) {
            criteria = criteria.and("userId").is(userId);
			query.addCriteria(criteria);
        }
        if(StringUtils.isNotEmpty(nikeName)) {
            criteria = criteria.and("nikeName").is(nikeName);
			query.addCriteria(criteria);
        }
        if (null != type && !"".equals(type) && null != type
				&& !"".equals(type)){
			criteria = criteria.and("type").is(type);
		}
        // 时间段
        if (null != startDate && !"".equals(startDate) && null != endDate
        		&& !"".equals(endDate)) {
        	criteria = criteria.andOperator(Criteria.where("update_time")
        			.gte(startDate).lte(endDate));
        }
		query.addCriteria(criteria);
		return getMongoTemplate().count(query, "banned");
	}
	
	@Override
	public List<GameBanned> searchList(Long serverId, Date startDate,
			Date endDate , String userId , String nikeName, Integer type, int start,
			int	limit) {
		Query query = new Query();
		Criteria criteria = new Criteria();
		if (null != serverId && !"".equals(serverId) && null != serverId
				&& !"".equals(serverId)){
			criteria = criteria.and("index").is(serverId);
		}
        if(StringUtils.isNotEmpty(userId)) {
            criteria = criteria.and("userId").is(userId);
			query.addCriteria(criteria);
        }
        if(StringUtils.isNotEmpty(nikeName)) {
            criteria = criteria.and("nikeName").is(nikeName);
			query.addCriteria(criteria);
        }
        if (null != type && !"".equals(type) && null != type
				&& !"".equals(type)){
			criteria = criteria.and("type").is(type);
		}
        // 时间段
        if (null != startDate && !"".equals(startDate) && null != endDate
        		&& !"".equals(endDate)) {
        	criteria = criteria.andOperator(Criteria.where("update_time")
        			.gte(startDate).lte(endDate));
        }
        query.addCriteria(criteria);
        query.with(new Sort(Sort.Direction.DESC, "update_time"));
        query.skip(start);
        query.limit(limit);
        return getMongoTemplate().find(query, GameBanned.class, "banned");
	}
}
