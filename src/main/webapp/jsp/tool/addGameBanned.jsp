<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="com.xmbl.ops.enumeration.EnumBannedType" %>
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
		<title>禁言|封号</title>
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
			<div class="mini-title">当前位置：禁言|封号</div>
		</header>
		<article class="container-fluid" id="post-container">
		<div class="form-horizontal" >
			<div class="form-group">
				<label class="col-sm-1 control-label">游戏区服：</label>
				<div class="col-sm-2">
					 <select name="gameserverId" id="gameserver-id" class="gameserverId form-control">
					 </select>
				</div>
				 <label class="col-sm-1 control-label">操作类型：</label>
				<div class="col-sm-1">
					<select name="type" class="type form-control">
						<option value="">全部</option>
						<c:set var="enumTypes" value="<%= EnumBannedType.values() %>"/>
						<c:forEach var="enumType" items="${ enumTypes }">
						<option value="${ enumType.id }" <c:if test="${ enumType.id == type }">selected = "selected"</c:if>>${ enumType.desc  }</option>
						</c:forEach>
					</select>
				</div>
			</div>
			<div class="form-group">
				<label class="col-sm-1 control-label">玩家id：</label>
				<div class="col-sm-2">
				<input type="text" value="${userId}" class="userId form-control"
					maxLength="30" />
				</div>
				 <label class="col-sm-1 control-label">玩家昵称：</label>
				<div class="col-sm-2">
				<input type="text" value="${nikeName}" class="nikeName form-control" />
				</div>
			<label class="col-sm-1 control-label">禁言|封号时间:</label>
			<div class="col-sm-2">
			<input class="startTime form-control form-date" type="text" value="${ func:formatDate(gameserver.creattime) }"  data-date-format="yyyy-mm-dd hh:mm:ss" />
			</div>
			<label class="col-sm-1 control-label">至</label>
			<div class="col-sm-2">
			<input class="endTime form-control form-date" type="text" value="${ func:formatDate(gameserver.creattime) }"  data-date-format="yyyy-mm-dd hh:mm:ss" />
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
				seajs.use(['lib/jquery','util/bootstrap.datetimepicker.zh-CN', 'module/UserInfo','module/Validator', 'util/ajaxPromise'], function($,datetimepicker, UserInfo, Validator, ajaxPromise) {
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
				// 加载服务器列表
				var gameserverList;
				UserInfo.initTeam('gameserver-id', '${ gameserverId }');
				var postContainer = $('#post-container');
				$('#confirm-btn').on('click', function(e) {
				var el = $(this), validator = new Validator(), data = {};
							data.serverId = postContainer.find('.gameserverId').val();
							data.userId = postContainer.find('.userId').val().trim();
							data.nikeName = postContainer.find('.nikeName').val().trim();
							data.type = postContainer.find('.type').val();
							data.startTime = postContainer.find('.startTime').val().trim();
                            data.endTime = postContainer.find('.endTime').val().trim();
							if(!data.serverId) {
							}
							if(!validator.start()) {
								return;
							}
							el.prop('disabled', true);
							ajaxPromise({
								url: window.basePath + 'tool/addGameBanned',
								type: 'POST',
								data: data,
								dataType: 'json'
							}).then(function(data) {
								document.location.href = window.basePath + 'tool/gameBannedInfoList';
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
