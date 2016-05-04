<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<%@ include file = "./jsp/inc/version.jsp" %>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta charset="utf-8">
	<title>平台管理系统</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="keywords" content="">
	<meta name="author" content="">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
    <link rel="shortcut icon" href="<%=basePath %>image/logo/favicon.ico">
	<script type="text/javascript">
	var basePath = '<%=basePath%>';
	(function(){MX=window.MX||{};var g=function(a,c){for(var b in c)a.setAttribute(b,c[b])};MX.load=function(a){var c=a.js,b=c?".js":".css",d=-1==location.search.indexOf("jsDebug"),e=a.js||a.css;-1==e.indexOf("http://")?(e=(a.path||window.basePath)+((c?"js/":"css/")+e)+(!d&&!c?".source":""),b=e+(a.version?"_"+a.version:"")+b):b=e;d||(d=b.split("#"),b=d[0],b=b+(-1!=b.indexOf("?")?"&":"?")+"r="+Math.random(),d[1]&&(b=b+"#"+d[1]));if(c){var c=b,h=a.success,f=document.createElement("script");f.onload=function(){h&&h();f=null};g(f,{type:"text/javascript",src:c,async:"true"});document.getElementsByTagName("head")[0].appendChild(f)}else{var c=b,i=a.success,a=document.createElement("link");g(a,{rel:"stylesheet"});document.getElementsByTagName("head")[0].appendChild(a);g(a,{href:c});i&&(a.onload=function(){i()})}}})();
	</script>
	<link href="<%=basePath %>css/bootstrap/bootstrap.3.3.5.min.css" rel="stylesheet">
	<link href="<%=basePath %>css/common_${ CSS_COMMON_VERSION }.css" rel="stylesheet">
	<style type="text/css">
		.sign-window{
			width: 422px;
			position:absolute;
			top: 50%;
			left: 50%;
			margin-left: -211px;
			margin-top: -180px;
		},
		.security-img {
			width: 85px;
			height: 22px;
			vertical-align: middle;
		}
	</style>
</head>
<body>
	<div class="sign-window">
		<div class="panel panel-default">
			<div class="panel-heading ui-flex-between">
			<span><h3>平台管理系统</h3></span>
			<img src="<%=basePath %>image/logo/logo.png" width="222" height="62">
			</div>
			<div class="panel-body">
				<form id="login-form">
					<div class="form-group">
						<input type="text" class="form-control account" placeholder="请输入账号" name="loginId">
					</div>
					<div class="form-group">
						<input type="password" class="form-control password" placeholder="请输入密码" name="password">
					</div>
					<div class="form-group ui-flex-between">
						<input type="text" style="height:50px;" class="form-control security-code" placeholder="请输入验证码" name="securityCode">
						<img class="security-img ml10" src="<%=basePath%>login/securityCode" title="单击获得新验证码" />
					</div>
					<div class="form-group ui-flex-between">
						<button type="submit" class="btn btn-danger flex-grow confirm">登录</button>
						<button type="reset" class="btn btn-default flex-grow ml20 reset">清除</button>
					</div>
				</form>
			</div>
			<div class="panel-footer">无法登录？请联系运营团队</div>
		</div>
	</div>
<script type="text/javascript">
	MX.load({
		js: 'lib/sea',
		version: '${ JS_LIB_SEA_VERSION }',
		success: function() {
			if(top !== window) {
				top.location.href = window.basePath + '/login.jsp';
			}
			seajs.use(['lib/jquery', 'page/login'], function($, Login) {
				var login = new Login('login-form');
			});
		}
	});
</script>
</body>
</html>

