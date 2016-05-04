<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="com.xmbl.ops.enumeration.EnumGameServerStatus" %>
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
<title>服务器列表</title>
<meta http-equiv="keywords" content=""/>
<meta http-equiv="description" content=""/>
<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>image/logo/favicon.ico">
<link rel="stylesheet" href="<%=basePath %>css/bootstrap/bootstrap.3.3.5.min.css">
<link href="<%=basePath %>css/bootstrap/bootstrap-datetimepicker.min.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" href="<%=basePath %>css/common_${ CSS_COMMON_VERSION }.css">
<link rel="stylesheet" href="<%=basePath %>css/exam/problem.css">
<script type="text/javascript">
	var path = '<%=path %>';
	var basePath = '<%=basePath%>';
	(function(){MX=window.MX||{};var g=function(a,c){for(var b in c)a.setAttribute(b,c[b])};MX.load=function(a){var c=a.js,b=c?".js":".css",d=-1==location.search.indexOf("jsDebug"),e=a.js||a.css;-1==e.indexOf("http://")?(e=(a.path||window.basePath)+((c?"js/":"css/")+e)+(!d&&!c?".source":""),b=e+(a.version?"_"+a.version:"")+b):b=e;d||(d=b.split("#"),b=d[0],b=b+(-1!=b.indexOf("?")?"&":"?")+"r="+Math.random(),d[1]&&(b=b+"#"+d[1]));if(c){var c=b,h=a.success,f=document.createElement("script");f.onload=function(){h&&h();f=null};g(f,{type:"text/javascript",src:c,async:"true"});document.getElementsByTagName("head")[0].appendChild(f)}else{var c=b,i=a.success,a=document.createElement("link");g(a,{rel:"stylesheet"});document.getElementsByTagName("head")[0].appendChild(a);g(a,{href:c});i&&(a.onload=function(){i()})}}})();
</script>
</head>
<body>
	<c:set var="searchStr" value="serverId=${ serverId }
							&serverName=${ serverName }
							&status=${ status }&" />
	<c:set var="preUrl" value="gameServerList?${ searchStr }" />
	<header class="ui-page-header">
		<div class="mini-title">当前位置：服务器列表</div>
	</header>
	<article class="container-fluid">
		<form class="form-inline search-form">
			<div class="form-group">
				<label>服务器ID</label>
				<input type="text" class="form-control" value="${ serverId }" name="serverId" />
			</div>
			<div class="form-group">
				<label>服务器名</label>
				<input type="text" class="form-control" value="${ serverName }" name="serverName" />
			</div>
			<div class="form-group">
				<label>服务器状态</label>
				<select name="status" class="form-control">
					<option value="">全部</option>
					<c:set var="enumStatuses" value="<%= EnumGameServerStatus.values() %>"/>
					<c:forEach var="enumStatus" items="${ enumStatuses }">
					<option value="${ enumStatus.id }" <c:if test="${ enumStatus.id == status }">selected = "selected"</c:if>>${ enumStatus.desc }</option>
					</c:forEach>
				</select>
			</div>
			<div class="form-group">
				<button class="btn btn-primary">搜索</button>
			</div>
	<!--  		<div class="form-group">
				<a href="#" class="btn btn-success ml10" id="add-gameserver-btn">添加服务器</a>
			</div>-->
			<div class="form-group">
				<a href="<%=basePath%>game/gameServerInfo" class="btn btn-success ml10">添加服务器</a>
			</div>
		</form>
		<table class="table table-hover table-bordered table-condensed">
			<thead>
				<tr>
					<th colspan="15">
						<button class="btn btn-primary btn-xs" id="batch-audit-btn">批量开服/关服</button>
					</th>
				</tr>
				<tr class="info">
					<th class="min-w20">
						<input type="checkbox" id="all-check" />
					</th>
					<th>ID</th>
					<th>服务器ID</th>
					<th class="min-w40">服务器名</th>
					<th class="min-w40">服务器ip</th>
					<th>服务器端口</th>
					<th>服务器状态</th>
					<th class="min-w50">服务器开服时间</th>
					<th>操作人</th>
				</tr>
			</thead>
			<tbody id="gameserver-list">
				<c:forEach var="gameServer" items="${ gameServerList }">
				<tr>
					<td>
						<input type="checkbox" name="checkbox" data-audited="${ gameServer.status }" data-gameserver-id="${ gameServer.id }"/>
					</td>
					<td><a href="<%=basePath %>game/gameServerInfo?id=${ gameServer.id }">${ gameServer.id }</a></td>
					<td>${ gameServer.serverid }</td>
					<td>${ gameServer.servername }</td>
					<td>${ gameServer.serverip }</td>
					<td>${ gameServer.serverport }</td>
				    <td>${ gameServer.statusForStr }</td>
					<td>${ func:formatDate(gameServer.creattime) }</td>
					<td>${ gameServer.operator }</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
		<%@ include file = "../inc/newpage.jsp" %>
	</div>
	<div id="modal-dialog" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
					<h4 class="modal-title"></h4>
				</div>
				<div class="modal-body"></div>
				<div class="modal-footer"></div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
<script type="text/javascript">
	MX.load({
		js: 'lib/sea',
		version: '${ JS_LIB_SEA_VERSION }',
		success: function() {
			seajs.use(['lib/jquery', 'util/bootstrap.datetimepicker.zh-CN', 'module/Dialog', 'module/GameServer', 'util/ajaxPromise'], function($, datetimepicker, Dialog, gameServer, ajaxPromise) {
				// 全选按钮
				var allCheck = $('#all-check'),
					gameserverList = $('#gameserver-list'), gameserverIds, data,
					dialog = new Dialog('modal-dialog'),
					checkList = gameserverList.find('tr input').filter('[name="checkbox"]');
				// 绑定datetimepicker插件
				$('.form-date').datetimepicker({
					language: 'zh-CN',/*加载日历语言包，可自定义*/
					weekStart: 1,
					todayBtn:  1,
					autoclose: 1,
					todayHighlight: 1,
					minView: 2,
					forceParse: 0,
					showMeridian: 1
				});
				
				// 创建服务器
				$('#add-gameserver-btn').on('click', function(e) {
					var el = $(this);
					e.preventDefault();
					gameServer.addGameServer(el.attr('id'));
				});
				gameServerList = $('#gameserver-list');
				// 编辑服务器
				gameServerList.on('click', '.edit-btn', function(e) {
					var el = $(this), data;
					data = el.closest('tr').data();
					gameServer.editGameServer(data);
				});
				
				// 绑定全选
				allCheck.on('click', function(e) {
					var el = $(this);
					if(el.prop('checked')) {
						//checkList.filter(function(i, o) {
						//	return $(o).data('audited') === 0;
						//}).prop('checked', true);
						checkList.prop('checked', true);
					} else {
						checkList.prop('checked', false);
					}
				});
				// 取消全选
				gameserverList.on('click', 'tr input[name=checkbox]', function(e) {
					if(!$(this).prop('checked')) {
						allCheck.prop('checked', false);
					}
				});
				// 批量开服，关服
				$("#batch-audit-btn").on('click', function(e) {
					var el = $(this);
					data = {};
					data.gameserverIds = checkList.filter(':checked').map(function() {
						return $(this).data('gameserver-id');
					}).get().join();
					if(data.gameserverIds.length === 0) {
						alert('请选择待服务器！');
						return;
					}
					dialog.show({
						sizeClass: 'modal-sm',
						title: '批量操作',
						content: [
							'<div class="audit form-group">',
								'<label>服务器状态</label>',
								'<div>',
									'<label for="passed"><input type="radio" name="audit" id="passed" value="1"/>开启</label>',
									'<label for="unpassed" class="ml10"><input type="radio" name="audit" id="unpassed" value="0"/>关闭</label>',
								'</div>',
							'</div>'
						].join(''),
						source: el.attr('id'),
						renderCall: function() {
							var Self = this, result, reason, reasonTxt;
							result = Self._body.find('.result');
							reason = result.find('.why');
							reasonTxt = result.find('.reason-txt');
							Self._body.on('show.bs.modal', function(e) {
								$(this).find('.audit input').prop('checked', false);
								result.hide();
							});
							Self._body.on('click.bs.custom', '.audit input', function(e) {
								var el = $(this), auditStatus;
								if(el.prop('checked')) {
									auditStatus = +el.val();
									data.status = auditStatus;
								}
							});
						},
						confirm: function() {
							var Self = this, reasonTxt;
							if(!Self._body.find('.audit input').filter(':checked')[0]) {
								alert('请选择服务器状态');
								Self.enableConfirm();
								return;
							}
							ajaxPromise({
								url: window.basePath + 'game/updateGameServerStatus',
								type:'GET',
								data: data,
								dataType: 'json'
							}).then(function(data) {
								window.location.reload();
							}, function() {
								Self.enableConfirm();
							});
						}
					});
				});
			});
		}
	});
</script>
</body>
</html>
