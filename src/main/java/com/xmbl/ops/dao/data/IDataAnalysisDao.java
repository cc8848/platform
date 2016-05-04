package com.xmbl.ops.dao.data;

import java.util.Date;
import java.util.List;

import com.xmbl.ops.dao.base.IEntityDao;
import com.xmbl.ops.model.organization.DataAnalysis;

public interface IDataAnalysisDao  extends IEntityDao<DataAnalysis>{
	 List<DataAnalysis> searchListByDay(Date startTime, Date endTime);
}
