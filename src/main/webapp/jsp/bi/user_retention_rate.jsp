<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/Functions" prefix="func"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
	<%@ include file = "../inc/version.jsp" %>
	<head>
		<meta charset="UTF-8">
		<title>用户留存分析</title>
		<link href="<%=basePath%>css/bootstrap/bootstrap.3.3.5.min.css" rel="stylesheet" type="text/css"/>
		<link href="<%=basePath%>css/common_${ CSS_COMMON_VERSION }.css" rel="stylesheet" type="text/css"/>
		<style type="text/css">
			.low-retention {
				background-color: #b6f2f3;
			}
			.medium-retention {
				background-color: #8ee6ea;
			}
			.high-retention {
				background-color: #5dcacf;
			}
		</style>
		<script type="text/javascript">
			var path = '<%=path %>';
			var basePath = '<%=basePath%>';
			(function(){MX=window.MX||{};var g=function(a,c){for(var b in c)a.setAttribute(b,c[b])};MX.load=function(a){var c=a.js,b=c?".js":".css",d=-1==location.search.indexOf("jsDebug"),e=a.js||a.css;-1==e.indexOf("http://")?(e=(a.path||window.basePath)+((c?"js/":"css/")+e)+(!d&&!c?".source":""),b=e+(a.version?"_"+a.version:"")+b):b=e;d||(d=b.split("#"),b=d[0],b=b+(-1!=b.indexOf("?")?"&":"?")+"r="+Math.random(),d[1]&&(b=b+"#"+d[1]));if(c){var c=b,h=a.success,f=document.createElement("script");f.onload=function(){h&&h();f=null};g(f,{type:"text/javascript",src:c,async:"true"});document.getElementsByTagName("head")[0].appendChild(f)}else{var c=b,i=a.success,a=document.createElement("link");g(a,{rel:"stylesheet"});document.getElementsByTagName("head")[0].appendChild(a);g(a,{href:c});i&&(a.onload=function(){i()})}}})();
		</script>
	</head>
	<body>
		<header class="ui-page-header">
			<div class="mini-title">用户留存分析</div>
		</header>
	<article class="container-fluid">
			<div id="filter-container" class="form-inline search-form">
				<div class="form-group">
					<input type="text" data-date-format="yyyy-mm-dd" class="form-control form-date start-date" value="${startDate}"> -
					<input type="text" data-date-format="yyyy-mm-dd" class="form-control form-date end-date" value="${endDate}">
				</div>
				<div class="form-group">
					<label for="day" class="radio-inline">
						<input id="day" type="radio" name="type" value="1" checked>日
					</label>
					<label for="month" class="radio-inline">
						<input id="month" type="radio" name="type" value="2">月
					</label>
				</div>
			</div>
			<div class="panel panel-default">
				<div class="panel-heading ui-flex-between"><span>用户数据明细</span><a id="btn-export" href="<%=basePath%>generateDayRemain/exportDayRemain?startDate=${startDate}&endDate=${endDate}&type=1" class="btn btn-success btn-xs">导出</a></div>
				<div class="panel-body">
					<table id="user-retention-container" class="table table-bordered table-hover"></table>
				</div>
			</div>
		</article>
		<script id="user-retention-tmpl" type="text/html">
			<thead>
				<tr>
					<td>日期</td>
					<td>新增用户</td>
					{{each days}}
					<td>{{$value}}{{unit}}后</td>
					{{/each}}
				</tr>
			</thead>
			{{each userData}}
				<tr>
					<td>{{$value.date}}</td>
					<td>{{$value.newlogin}}</td>
					{{each $value.retaintions as retention}}
					{{if retention === 0}}
						<td></td>
					{{else}}
					<td class="{{if retention < 20}}low{{else if retention < 40}}medium{{else}}high{{/if}}-retention">{{retention}}%</td>
					{{/if}}
					{{/each}}
				</tr>
			{{/each}}
		</script>
		<script type="text/javascript">
			MX.load({
				js: 'lib/sea',
				version: '${ JS_LIB_SEA_VERSION }',
				success: function() {
					seajs.use(['lib/jquery', 'util/bootstrap.datetimepicker.zh-CN', 'util/ajaxPromise', 'util/artTemplate'], function($, datetimepicker, ajaxPromise, tmpl) {
						var updateData, userRetaintionContainer, filterContainer, btnExport;
						userRetaintionContainer = $('#user-retention-container');
						filterContainer = $('#filter-container');
						btnExport = $('#btn-export');
						updateData = function() {
							var config = {
								startDate: filterContainer.find('.start-date').val(),
								endDate: filterContainer.find('.end-date').val(),
								type: filterContainer.find('[name="type"]').filter(':checked').val()
							};
							ajaxPromise({
								url: window.basePath + 'generateDayRemain/daDayRemainSearch',
								type: 'GET',
								data: config,
								dataType: 'json'
							}).then(function(data) {
								var result = data.result;
								if(result.length === 0) {
									alert('当前时间段暂无数据');
									return;
								}
								result.forEach(function(o) {
									o.retaintions.forEach(function(retention, i) {
										o.retaintions[i] = +(retention.slice(0, -1));
									});
								});
								// render table
								userRetaintionContainer.html(tmpl('user-retention-tmpl', {
									days: [1, 2, 3, 4, 5, 6, 7],
									unit: config.type === '1' ? '天' : '月',
									userData: result
								}));
								btnExport.attr('href', window.basePath + 'generateDayRemain/exportDayRemain?startDate=' + config.startDate + '&endDate=' + config.endDate + '&type=' + config.type);
							});
						};
						filterContainer.find('[name="type"]').on('change', function(e) {
							updateData();
						});
						filterContainer.find('.form-date').datetimepicker({
							language: 'zh-CN',/*加载日历语言包，可自定义*/
							weekStart: 1,
							todayBtn: 1,
							autoclose: 1,
							todayHighlight: 1,
							minView: 2,
							forceParse: 0,
							showMeridian: 1
						}).on('changeDate', function(e) {
							updateData();
						});
						updateData();
					});
				}
			});
		</script>
	</body>
</html>