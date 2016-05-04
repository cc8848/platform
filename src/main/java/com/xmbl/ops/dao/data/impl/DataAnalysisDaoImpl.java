package com.xmbl.ops.dao.data.impl;

import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.xmbl.ops.dao.base.EntityDaoMPDBImpl;
import com.xmbl.ops.dao.data.IDataAnalysisDao;
import com.xmbl.ops.model.organization.DataAnalysis;

@Repository
public class DataAnalysisDaoImpl extends EntityDaoMPDBImpl<DataAnalysis> implements IDataAnalysisDao{
	public List<DataAnalysis> searchListByDay(Date startTime, Date endTime) {
		Map<String, Object> para = new HashMap<String, Object>();
		para.put("startTime", startTime);
		para.put("endTime", endTime);
		List<DataAnalysis> results = getSqlSessionTemplate().selectList(getNameSpace() + ".searchListByDay", para);
		return results;
	}

}
