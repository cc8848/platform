package com.xmbl.ops.controller.data;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xmbl.ops.dto.ResponseResult;
import com.xmbl.ops.model.organization.DataAnalysis;
import com.xmbl.ops.service.data.DataAnalysisService;
import com.xmbl.ops.util.DateUtils;
import com.xmbl.ops.controller.organization.AbstractController;

@Controller
@RequestMapping(value = "/data")
public class DataAnalysisController extends AbstractController{
	private static final int limit = 30;
	private static DecimalFormat decimalFormat = new DecimalFormat("##.0");
	private static DecimalFormat newLoginRateFormat = new DecimalFormat("#0.00");
	private static  DecimalFormat    df   = new DecimalFormat("######0.0");
	
	@Autowired
	protected DataAnalysisService dataAnalysisService;
	/*
	 * 日关键数据---
	 * data_day_analysis
	 * 查询参数：日期   游戏id  平台id   服务器id 
	 * 
	 */
	@RequestMapping(value = "/dataDayAnalysis")
	public String dataDayAnalysis(HttpServletRequest request, ModelMap model) {
		Date date = new Date(); 
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, -1);
		calendar.add(Calendar.DAY_OF_MONTH, -1);
		model.addAttribute("startDate", DateUtils.formatDate(calendar.getTime(), "yyyy-MM-dd"));
		model.addAttribute("endDate", DateUtils.formatDate(date, "yyyy-MM-dd"));
		return "data/data_day_analysis";
	}
	
	@RequestMapping(value = "/dataDaySearch")
	public @ResponseBody ResponseResult dataDaySearch(HttpServletRequest request,ModelMap model,String startDate,
			String endDate, Integer type) {
		if (type==1) {//日分析
			List<DataAnalysis> dataDayAnalysisList = Collections.emptyList();
			Date startTime = DateUtils.parseDate(startDate, "yyyy-MM-dd");
			Date endTime = DateUtils.parseDate(endDate, "yyyy-MM-dd");
			dataDayAnalysisList = dataAnalysisService.searchListByDay(startTime, endTime);
			Date date = null;
			for(DataAnalysis dataDay : dataDayAnalysisList) {
				date = dataDay.getCreatetime();
				if(date != null)
					dataDay.setCreateTimeForStr(DateUtils.formatDate(date, "yyyy-MM-dd"));
			}
			JsonConfig config = new JsonConfig();
//			config.setExcludes(new String[] {"id", "newLoginRate", "logDate","audioBuy","allImageAlive","imageAlive"});
			return successJson(JSONArray.fromObject(dataDayAnalysisList, config));
		}
		return successJson();
	}
	
	/*
	 * 月关键数据---
	 * data_month_analysis
	 * 
	 */
	
	
	/*
	 * 总关键数据---
	 * data_all_analysis
	 * 
	 */
	
	
	/*
	 * 日留存---
	 * user_day_active_retention
	 * 
	 */
	@RequestMapping(value = "/userDayActiveRetention")
	public String userDayActiveRetention(HttpServletRequest request, ModelMap model) {
		Date date = new Date(); 
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, -1);
		calendar.add(Calendar.DAY_OF_MONTH, -1);
		model.addAttribute("startDate", DateUtils.formatDate(calendar.getTime(), "yyyy-MM-dd"));
		model.addAttribute("endDate", DateUtils.formatDate(date, "yyyy-MM-dd"));
		return "data/dailyUserPay";
	}
	
	/*
	 * 付费留存---
	 * user_pay_retention
	 * 
	 */
	
	
	
}
