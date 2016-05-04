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
		<title>发送邮件</title>
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
<script language="javascript"> 
function AddElement(mytype){ 
var mytype,TemO=document.getElementById("add"); 
var newInput = document.createElement("input");  
newInput.type=mytype;  
newInput.name="input1"; 
TemO.appendChild(newInput); 
var newline= document.createElement("br"); 
TemO.appendChild(newline); 
} 
</script>
</head>
	<body>
		<header class="ui-page-header">
			<div class="mini-title">当前位置：发送邮件</div>
		</header>
		<article class="container-fluid" id="post-container">
		<div class="form-horizontal">
			<div class="form-group">
				 <label class="col-sm-2 control-label">邮件标题</label>
				<div class="col-sm-8">
				<input type="text" value="" class="title form-control"
					maxLength="30" />
				</div>
			</div>
			<div class="form-group">
				 <label class="col-sm-2 control-label">邮件内容</label>
				<div class="col-sm-8">
				<textarea class="content form-control" rows="4"></textarea>
				</div>
			</div>
			<div class="form-group" id="add">
			<label class="col-sm-2 control-label">添加奖励：</label>
			    <label class="col-sm-2 control-label">
			    <select class="typeItem form-control add-content" name="typeItem">
						<option value="0">道具</option>
						<option value="1">金币</option>
						<option value="2">钻石</option>
			    </select></label>
				<label class="col-sm-1 control-label">道具id：</label>
				<div class="col-sm-2 control-label">
				<input type="text" value="" class="typeItemId form-control"
					maxLength="30" />
				</div>
				 <label class="col-sm-1 control-label">数量：</label>
				<div class="col-sm-2 control-label">
				<input type="text" value="" class="typeItemCount form-control" />
				</div>
			</div>
			<div class="form-group" id="add">
			<label class="col-sm-2 control-label">添加奖励：</label>
			    <label class="col-sm-2 control-label">
			    <select class="typeItem form-control add-content" name="typeItem">
						<option value="0">道具</option>
						<option value="1">金币</option>
						<option value="2">钻石</option>
			    </select></label>
				<label class="col-sm-1 control-label">道具id：</label>
				<div class="col-sm-2 control-label">
				<input type="text" value="" class="typeItemId form-control" name="typeItemId"
					maxLength="30" />
				</div>
				 <label class="col-sm-1 control-label">数量：</label>
				<div class="col-sm-2 control-label">
				<input type="text" value="" class="typeItemCount form-control"  name="typeItemCount"/>
				</div>
			</div>
			<div class="form-group">
			<label class="col-sm-2 control-label">发送时间:</label>
			<div class="col-sm-8">
			<input class="createTime form-control form-date" type="text" value="${ func:formatDate(gameserver.creattime) }"  data-date-format="yyyy-mm-dd HH:mm:ss" />
			</div>
			</div>
			 <div class="form-group">
				<label class="col-sm-2 control-label">服务器列表</label>
				<div class="col-sm-10">
				<div class="checkbox district" id="gameserver-list">
			    <label class="checkbox-inline"><input type="checkbox" id="all-check" name="game-server-all" class="check-all" value="0">全部
				</label>
				<br>
					<c:forEach var="gameServer" items="${ gameServerList }" varStatus="status">
						<label class="checkbox-inline"><input type="checkbox"
							name="game-server" value="${ gameServer.index}">${ gameServer.name }</label>
							<c:if test="${status.count%5==0}">
							</br>
							</c:if>
					</c:forEach>
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
				seajs.use(['lib/jquery','util/bootstrap.datetimepicker.zh-CN','module/Dialog', 'module/Validator', 'util/ajaxPromise'], function($,datetimepicker, Dialog, Validator, ajaxPromise) {
	            var allCheck = $('#all-check'),
	            dialog = new Dialog('modal-dialog'),
	            gameserverList = $('#gameserver-list'),
	            checkList =  gameserverList.find('input').filter('[name="game-server"]');
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
				// 绑定全选
				allCheck.on('click', function(e) {
				
					var el = $(this);
					if(el.prop('checked')) {
						checkList.prop('checked', true);
					} else {
						checkList.prop('checked', false);
					}
				});
				$('#confirm-btn').on('click', function(e) {
				var el = $(this), validator = new Validator(), data = {};
				            data.title = postContainer.find('.title').val();
							data.content = postContainer.find('.content').val();
							data.typeItem = postContainer.find('.typeItem').val();
							data.typeItemId = postContainer.find('.typeItemId').val().trim();
							data.typeItemCount = postContainer.find('.typeItemCount').val().trim();
							data.gameserverIdArray = postContainer.find('[name="game-server"]').filter(':checked').map(function() {
									return $(this).val();
								}).get();
							validator.add(data.gameserverIdArray, 'minLength:1', function() {
								alert('至少选择一个服务器');
							});
							data.gameserverIdArray = data.gameserverIdArray.join();
							data.createTime = postContainer.find('.createTime').val().trim();
							
							data.typeItemList = postContainer.find('[name="typeItem"]').map(function() {
									return $(this).val();
								}).get();
							data.typeItemList = data.typeItemList.join();

							if(!data.Id) {
								
							}
							if(!validator.start()) {
								return;
							}
							el.prop('disabled', true);
							ajaxPromise({
							//	url: window.basePath + 'tool/addGameEmail',
								type: 'POST',
								data: data,
								dataType: 'json'
							}).then(function(data) {
							//	document.location.href = window.basePath + 'tool/emailInfoList';
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
