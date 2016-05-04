<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="/WEB-INF/tlds/Functions" prefix="func"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!doctype html>
<html lang="zh-CN">
<%@ include file = "../inc/version.jsp" %>
<head>
	<title>用户详细</title>
	<meta charset="UTF-8">
	<link type="image/x-icon" rel="shortcut icon" href="<%=basePath %>image/logo/favicon.ico">
	<link rel="stylesheet" href="<%=basePath %>css/bootstrap/bootstrap.3.3.5.min.css" />
	<link rel="stylesheet" href="<%=basePath %>css/common_${ CSS_COMMON_VERSION }.css" />
	<script type="text/javascript">
		var basePath = '<%=basePath%>';
		(function(){MX=window.MX||{};var g=function(a,c){for(var b in c)a.setAttribute(b,c[b])};MX.load=function(a){var c=a.js,b=c?".js":".css",d=-1==location.search.indexOf("jsDebug"),e=a.js||a.css;-1==e.indexOf("http://")?(e=(a.path||window.basePath)+((c?"js/":"css/")+e)+(!d&&!c?".source":""),b=e+(a.version?"_"+a.version:"")+b):b=e;d||(d=b.split("#"),b=d[0],b=b+(-1!=b.indexOf("?")?"&":"?")+"r="+Math.random(),d[1]&&(b=b+"#"+d[1]));if(c){var c=b,h=a.success,f=document.createElement("script");f.onload=function(){h&&h();f=null};g(f,{type:"text/javascript",src:c,async:"true"});document.getElementsByTagName("head")[0].appendChild(f)}else{var c=b,i=a.success,a=document.createElement("link");g(a,{rel:"stylesheet"});document.getElementsByTagName("head")[0].appendChild(a);g(a,{href:c});i&&(a.onload=function(){i()})}}})();
	</script>
</head>
	<body>
		<header class="ui-page-header">
			<div class="mini-title">用户详情</div>
		</header>
		<article class="container-fluid">
			<div id="user-info" data-id="" class="search-form form-inline">
				<div class="form-group">
					<label>玩家Id：</label><span class="ui-form-display">${ player.paleyId }</span>
				</div>
				<div class="form-group">
					<label>玩家昵称：</label><span class="ui-form-display">${ player.playName }</span>
				</div>
			<div class="panel panel-default">
				<div class="panel-heading">详细信息</div>
				<div class="panel-body row form-horizontal">
					<div class="form-group">
						<label class="col-sm-1 control-label">手机号：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ users.mobile }</div>
						<label class="col-sm-1 control-label">省份：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ users.edu_province }</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label">城市：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ users.edu_city }</div>
						<label class="col-sm-1 control-label">学校：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ users.edu_school }</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label">版本：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ users.version }</div>
						<label class="col-sm-1 control-label">邀请码：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ users.invite_code }</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label">被邀请码：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ users.invited_code }</div>
						<label class="col-sm-1 control-label">手机类型：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ phoneType }</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label">手机绑定：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ isMobilebind }</div>
						<label class="col-sm-1 control-label">设备id：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ users.deviceid }</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label">设备绑定：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ isBind }</div>
						<label class="col-sm-1 control-label">密码：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ users.password }</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label">消息服务：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ users.pushtoken }</div>
						<label class="col-sm-1 control-label">消息推送服务号：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ users.push_server }</div>
					</div>
					<div class="form-group">
						<label class="col-sm-1 control-label">头像：</label>
						<div class="col-sm-5 pl0"><img src="${ users.profile_image_url }" class="round-img90"></div>
						<label class="col-sm-1 control-label">渠道：</label>
						<div class="col-sm-5 pl0 ui-form-display">${ users.channel }</div>
					</div>
				</div>
			</div>
		</article>
		<script type="text/javascript">
			MX.load({
				js: 'lib/sea',
				version: '151126a',
				success: function() {
					seajs.use(['lib/jquery', 'module/Validator', 'util/ajaxPromise'], function($, Validator, ajaxPromise) {
						var userInfo = $('#user-info');
						userInfo.on('click', '.btn-save', function(e) {
							var el = $(this), validator, data = {},
								_score;
							validator = new Validator();
							_score = userInfo.find('.score');
							data.scoreAdd = _score.val().trim();
							data.isBlock = userInfo.find('.lock').prop('checked');
							validator.add(data.scoreAdd, 'isNaturalNum', function() {
								alert('请输入合法的积分');
								_score.focus();
							});
							if(!validator.start()) {
								return;
							}
							data.userId = userInfo.data('id');
							el.prop('disabled', true);
							ajaxPromise({
								url: window.basePath + 'users/updateUsers',
								type: 'POST',
								data: data,
								dataType: 'json'
							}).then(function(data) {
								document.location.reload();
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