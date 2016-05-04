package com.xmbl.ops.service.data;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.xmbl.ops.dao.data.IDataAnalysisDao;
import com.xmbl.ops.model.organization.DataAnalysis;

@Service
public class DataAnalysisService {
	@Resource
	IDataAnalysisDao dataAnalysisDao;
	
	public List<DataAnalysis> searchListByDay(Date startDate,Date endDate) {
		List<DataAnalysis> dataDayList = dataAnalysisDao.searchListByDay(startDate,endDate);
		return dataDayList;
	}
}
