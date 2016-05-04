<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/Functions" prefix="func"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!doctype html>
<html lang="zh-CN">
	<%@ include file = "../inc/version.jsp" %>
	<head>
		<meta charset="utf-8"/>
		<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
		<title>服务器详细</title>
		<meta http-equiv="keywords" content=""/>
		<meta http-equiv="description" content=""/>
		<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>image/logo/favicon.ico">
		<link rel="stylesheet" href="<%=basePath %>css/bootstrap/bootstrap.3.3.5.min.css">
		<link href="<%=basePath %>css/bootstrap/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
		<link rel="stylesheet" href="<%=basePath %>css/common_${ CSS_COMMON_VERSION }.css">
		<style type="text/css">
			.illustration {
				width: 200px;
				height: 100px;
				background: #999;
			}
			.illustration[src] {
				height: auto;
			}
		</style>
		<script type="text/javascript">
			var path = '<%=path %>';
			var basePath = '<%=basePath%>';
			(function(){MX=window.MX||{};var g=function(a,c){for(var b in c)a.setAttribute(b,c[b])};MX.load=function(a){var c=a.js,b=c?".js":".css",d=-1==location.search.indexOf("jsDebug"),e=a.js||a.css;-1==e.indexOf("http://")?(e=(a.path||window.basePath)+((c?"js/":"css/")+e)+(!d&&!c?".source":""),b=e+(a.version?"_"+a.version:"")+b):b=e;d||(d=b.split("#"),b=d[0],b=b+(-1!=b.indexOf("?")?"&":"?")+"r="+Math.random(),d[1]&&(b=b+"#"+d[1]));if(c){var c=b,h=a.success,f=document.createElement("script");f.onload=function(){h&&h();f=null};g(f,{type:"text/javascript",src:c,async:"true"});document.getElementsByTagName("head")[0].appendChild(f)}else{var c=b,i=a.success,a=document.createElement("link");g(a,{rel:"stylesheet"});document.getElementsByTagName("head")[0].appendChild(a);g(a,{href:c});i&&(a.onload=function(){i()});}}})();
		</script>
	</head>
	<body>
		<header class="ui-page-header">
			<div class="mini-title">当前位置：服务器详细</div>
		</header>
		<article class="container-fluid" id="post-container">
		<div class="form-horizontal">
			<div class="form-group">
			    <input name="id"  value="${gameserver.id}" class="id form-control"  style="visibility:hidden"/>
				<label class="col-sm-2 control-label">服务器id：</label>
				<div class="col-sm-8">
					<input type="text" value="${gameserver.serverid}" class="serverId form-control"
						maxLength="30" />
				</div>
			</div>
			<div class="form-group">
				 <label class="col-sm-2 control-label">服务器名：</label>
				<div class="col-sm-8">
					 <input type="text" value="${gameserver.servername}" class="serverName form-control" />
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-2 control-label">服务器ip：</label>
				<div class="col-sm-8">
					 <input type="text" value="${gameserver.serverip}" class="serverIp form-control"
						maxLength="30" />
				</div>
			</div>
			<div class="form-group">
				 <label class="col-sm-2 control-label">服务器端口：</label>
				<div class="col-sm-8">
					 <input type="text" value="${gameserver.serverport}" class="serverPort form-control"
						maxLength="10" />
				</div>
			</div>
			<div class="form-group">
			<label class="col-sm-2 control-label">开服时间:</label>
			<div class="col-sm-8">
			<input class="createTime form-control form-date" type="text" value="${ func:formatDate(gameserver.creattime) }"  data-date-format="yyyy-mm-dd HH:mm:ss" />
			</div>
			</div>
			<div class="form-group">
				 <label class="col-sm-2 control-label">状态：</label>
				<div class="col-sm-8">
					 <select class="status form-control">
						<option <c:if test="${ gameserver.status == 1 }">selected= "selected"</c:if> value="1">开启</option>
						<option <c:if test="${ gameserver.status == 0 }">selected= "selected"</c:if> value="0">关闭</option>
					</select>
				</div>
			</div>
		</div>
	</article>
		<footer class="text-center ui-page-footer">
			<a class="btn btn-default min-w100" href="${referer }">返回</a>
			<button class="btn btn-primary min-w100 ml20" id="confirm-btn">提交</button>
		</footer>
		<div id="image-input" tabindex="-1" role="dialog" aria-hidden="true" class="modal fade">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button data-dismiss="modal" class="close"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body"></div>
					<div class="modal-footer"></div>
				</div>
			</div>
		</div>
		<script type="text/javascript">
			MX.load({
				js: 'lib/sea',
				version: '${ JS_LIB_SEA_VERSION }',
				success: function() {
				seajs.use(['lib/jquery','util/bootstrap.datetimepicker.zh-CN', 'module/Validator', 'util/ajaxPromise'], function($,datetimepicker, Validator, ajaxPromise) {
						// 绑定datetimepicker插件
				$('.form-date').datetimepicker({
					language: 'zh-CN',/*加载日历语言包，可自定义*/
					weekStart: 1,
					todayBtn:  1,
					autoclose: 1,
					todayHighlight: 1,
					minView: 0,
					forceParse: 0,
					showMeridian: 1
				});	
				var postContainer = $('#post-container');
				$('#confirm-btn').on('click', function(e) {
				var el = $(this), validator = new Validator(), data = {};
							data.Id = postContainer.find('.id').val();
							data.serverId = postContainer.find('.serverId').val();
							data.serverName = postContainer.find('.serverName').val().trim();
							data.serverIp = postContainer.find('.serverIp').val().trim();
							data.serverPort = postContainer.find('.serverPort').val().trim();
							data.status = postContainer.find('.status').val();
							data.createTime = postContainer.find('.createTime').val().trim();

							if(!data.Id) {
								
							}
							if(!validator.start()) {
								return;
							}
							el.prop('disabled', true);
							ajaxPromise({
								url: window.basePath + 'game/editGameServer',
								type: 'POST',
								data: data,
								dataType: 'json'
							}).then(function(data) {
								document.location.href = window.basePath + 'game/gameServerList';
							}, function() {
								el.prop('disabled', false);
							});
						});
					});
				}
			});
		</script>
	</body>
</html>
