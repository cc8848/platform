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
		<meta charset="UTF-8">
		<title>专题编辑页</title>
		<link href="<%=basePath %>css/bootstrap/bootstrap.3.3.5.min.css" rel="stylesheet" type="text/css">
		<link href="<%=basePath %>css/common_${ CSS_COMMON_VERSION }.css" rel="stylesheet" type="text/css">
		<link href="<%=basePath %>css/exam/editor_${ CSS_EXAM_EDITOR_VERSION }.css" rel="stylesheet" type="text/css">
		<link href="<%=basePath %>css/special.css" rel="stylesheet" type="text/css">
		<style type="text/css">
			.special-background {
				width: 320px;
				height: 220px;
				background-color: #3d4d0f;
				display: block;
			}
			.special-preview-container {
				width: 320px;
				flex-shrink: 0;
			}
			.module-item-text {
				border: 1px solid #ccc;
				padding: 6px 12px;
				border-radius: 4px;
				min-height: 40px;
			}
			.form-control-feedback {
				pointer-events: initial;
			}
			.preview-zone {
				padding: 15px 0;
			}
			.edittable {
				max-height: 300px;
				overflow-y: scroll;
			}
		</style>
		<script type="text/javascript">
			var path = '<%=path %>';
			var basePath = '<%=basePath %>';
			(function(){MX=window.MX||{};var g=function(a,c){for(var b in c)a.setAttribute(b,c[b])};MX.load=function(a){var c=a.js,b=c?".js":".css",d=-1==location.search.indexOf("jsDebug"),e=a.js||a.css;-1==e.indexOf("http://")?(e=(a.path||window.basePath)+((c?"js/":"css/")+e)+(!d&&!c?".source":""),b=e+(a.version?"_"+a.version:"")+b):b=e;d||(d=b.split("#"),b=d[0],b=b+(-1!=b.indexOf("?")?"&":"?")+"r="+Math.random(),d[1]&&(b=b+"#"+d[1]));if(c){var c=b,h=a.success,f=document.createElement("script");f.onload=function(){h&&h();f=null};g(f,{type:"text/javascript",src:c,async:"true"});document.getElementsByTagName("head")[0].appendChild(f)}else{var c=b,i=a.success,a=document.createElement("link");g(a,{rel:"stylesheet"});document.getElementsByTagName("head")[0].appendChild(a);g(a,{href:c});i&&(a.onload=function(){i()})}}})();
		</script>
	</head>
	<body>
		<article id="special-tab-content" class="tab-content">
	
			<section id="special-edit" role="tabpanel" class="tab-pane fade in active">
				<div class="ui-flex-between">
					<article class="special-edit-container flex-grow">
						<section id="special-module-info-container" class="panel panel-default">
							<div class="panel-heading">模块信息</div>
							<div class="panel-body">
								<ul id="special-module-tabs" role="tablist" class="nav nav-tabs">
										<li role="presentation" class="active">
										<a href="#special-module1" role="tab" data-toggle="tab">
											<span>模块</span>
										</a>
									</li>
								</ul>
								<section id="special-module-container" class="tab-content"></section>
							</div>
						</section>
					</article>
				</div>
			</section>
		</article>
		<div id="rich-text-dialog" tabindex="-1" role="dialog" aria-hidden="true" class="modal fade">
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
		<div id="formula-input" class="formula-input modal fade" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
						<h4 class="modal-title"></h4>
					</div>
					<div class="modal-body"></div>
					<div class="modal-footer"></div>
				</div>
			</div>
		</div>
		<script type="text/html" id="module-tab-tmpl">
			<li role="presentation">
				<a id="special-module{{id}}-tab" href="#special-module{{id}}" role="tab" data-toggle="tab">
					<span class="module-tab-title">模块{{num}}</span>
					<span class="glyphicon glyphicon-remove remove-module"></span>
				</a>
			</li>
		</script>
		<script type="text/html" id="new-module-tmpl">
			<section id="special-module{{id}}" role="tabpanel" class="special-module tab-pane fade pt15">
				<div class="form-group">
					<label>模块标题</label>
					<input type="text" placeholder="请输入标题，最长15个字" class="form-control special-module-title">
				</div>
				<div class="module-item-container">
					<div class="form-group">
						<label>图文</label>
						<label class="pull-right">
							<a href="#" class="modify-text">修改</a>
						</label>
						<div class="module-item module-item-text" data-lock="1"></div>
					</div>
				</div>
				<div class="ui-flex-between">
					<select class="form-control add-content">
						<option value="">+添加内容</option>
						<option value="0">图文</option>
						<option value="1">讲解</option>
						<option value="2">习题集</option>
						<option value="3">老师</option>
					</select>
					<button class="btn btn-primary btn-save-module ml20" {{if status === 2}}disabled{{/if}}>保存模块</button>
				</div>
			</section>
		</script>
		<script type="text/html" id="modules-tmpl">
			{{each sections as section sectionIndex}}
				<section id="special-module{{sectionIndex + 1}}" role="tabpanel" class="special-module tab-pane fade {{if sectionIndex === 0}}active in{{/if}} pt15">
					<div class="form-group">
						<label>模块标题</label>
						<input type="text" placeholder="请输入标题，最长15个字" class="form-control special-module-title" value="{{section.title}}">
					</div>
					<div class="module-item-container">
						{{each section.chapters}}
						{{if $value.type === 0}}
						<div class="form-group">
							<label>图文</label>
							<label class="pull-right">
								<a href="#" class="modify-text">修改</a>
							</label>
							<div class="module-item module-item-text" {{if $index === 0}}data-lock="1"{{/if}}>{{#$value.content}}</div>
						</div>
						{{else if $value.type === 1}}
						<div class="form-group has-feedback has-success" data-type="1">
							<div class="ui-input-group">
								<span class="ui-input-group-addon">讲解</span>
								<input type="text" placeholder="请填写讲解ID" class="form-control module-item module-item-media" value="{{$value.result.id}}">
							</div>
							<span class="glyphicon glyphicon-ok form-control-feedback module-item-validate"></span>
						</div>
						{{else if $value.type === 2}}
						<div class="form-group has-feedback has-success" data-type="2">
							<div class="ui-input-group">
								<span class="ui-input-group-addon">习题集</span>
								<input type="text" placeholder="请填写习题集ID" class="form-control module-item module-item-exercise" value="{{$value.result.id}}">
							</div>
							<span class="glyphicon glyphicon-ok form-control-feedback module-item-validate"></span>
						</div>
						{{else if $value.type === 3}}
						<div class="form-group has-feedback has-success" data-type="3">
							<div class="ui-input-group">
								<span class="ui-input-group-addon">老师</span>
								<input type="text" placeholder="请填写老师手机号" class="form-control module-item module-item-teacher"  value="{{$value.result.phoneNum}}">
							</div>
							<span class="glyphicon glyphicon-ok form-control-feedback module-item-validate"></span>
						</div>
						{{/if}}
						{{/each}}
					</div>
					<div class="ui-flex-between">
						<select class="form-control add-content">
							<option value="">+添加内容</option>
							<option value="0">图文</option>
							<option value="1">讲解</option>
							<option value="2">习题集</option>
							<option value="3">老师</option>
						</select>
						<button class="btn btn-primary btn-save-module ml20" {{if status === 2}}disabled{{/if}}>保存模块</button>
					</div>
				</section>
			{{/each}}
		</script>
		<script type="text/html" id="preview-tmpl">
			<header>
				<img src="{{banner}}" alt="" class="head-image">
				<div class="head-info">
					<span class="creat-time">10月14日</span>
				</div>
				<div class="head-description">{{description}}</div>
				<div class="head-actions">
					<span class="btn-share">{{shareCount}}</span>
					<span class="btn-comment">{{commentCount}}</span>
					<span class="btn-like">{{likeCount}}987</span>
				</div>
			</header>
			<ul class="main-sections">
				{{each sections as section sectionIndex}}
					<li class="section">
						<h2 class="title">{{section.title}}</h2>
						{{each section.chapters}}
							{{if $value.type === 0}}
								<div class="chapter text">
									<div class="content">{{#$value.content}}</div>
								</div>
							{{else if $value.type === 1}}
								<div class="chapter media">
									<div class="question">
										<div class="question-info">
											<span class="assist">题目</span>
											<span class="order">1</span>
											<span class="assist">【</span>
											<span class="subject">{{$value.result.subject}}</span>
											<span class="assist">】</span>
										</div>
										<div class="xxb-question stem">{{#$value.result.questionStem}}</div>
									</div>
									<div class="course">
										<div class="course-status course-status-start">
										</div>
										<div class="teacher teacher-excellent">{{$value.result.media.teacher.name}}老师</div>
										<div class="types">
											<span class="type">{{$value.result.media.type === 1 ? "音频讲解" : "白板讲解"}}</span>
										</div>
										<br class="clear">
									</div>
								</div>
							{{else if $value.type === 2}}
								<div class="chapter exercise">
									<div class="summary">
										<h3 class="title">{{$value.result.name}}</h3>
										<span class="free-status {{if $value.result.isFree}}free-isfree{{/if}}"></span>
										<div class="frame">
											<span class="sums">{{$value.result.exerciseCount}}</span>
											<span class="assist">道题</span>
											<span class="evaluate evaluate-good">{{$value.result.evaluates[0]}}</span>
											<span class="evaluate evaluate-middle">{{$value.result.evaluates[1]}}</span>
											<span class="evaluate evaluate-poor">{{$value.result.evaluates[2]}}</span>
										</div>
									</div>
								</div>
							{{else if $value.type === 3}}
								<div class="chapter teacher">
									<div class="summary">
										<img src="{{$value.result.teacher.avatar}}" alt="" class="avatar">
										<div class="frame infos-basic">
											<span class="name">{{$value.result.teacher.name}}老师</span>
											<span class="gender {{if +$value.result.teacher.gender === 2}}gender-female{{/if}}"></span>
										</div>
										<div class="frame infos-teachingQuality">
											<span class="teaching-age">{{$value.result.teacher.teachingAge}}</span>
											<span class="assist">年教龄</span>
											<span class="stars star-{{$value.result.teacher.star}}"></span>
										</div>
										<div class="frame infos-teachingScope">
											<span class="grades">{{$value.result.teacher.grades}}</span>
											<span class="subjects">{{$value.result.teacher.subjects}}</span>
										</div>
										<div class="frame infos-fans">
											<span class="leavewords-sums">{{$value.result.teacher.messagesCount}}</span>
											<span class="assist">条留言</span>
											<span class="follow-status">已关注</span>
										</div>
									</div>
								</div>
							{{/if}}
						{{/each}}
					</li>
				{{/each}}
			</ul>
		</script>
		<script type="text/javascript">
			MX.load({
				js: 'lib/sea',
				version: '${ JS_LIB_SEA_VERSION }',
				success: function() {
					seajs.use(['lib/jquery', 'lib/bootstrap', 'util/ajaxPromise', 'util/artTemplate', 'module/Knowledge', 'module/RichTextDialog', 'module/Validator'], function($, bootstrap,ajaxPromise, tmpl, Knowledge, RichTextDialog, Validator) {
						var baseInfoContainer = $('#special-base-info'),
							statisticContainer = $('#special-statistic-container'),
							knowledgeSelectionContainer = baseInfoContainer.find('.knowledge-selection-container'),
							otherSelectionContainer = baseInfoContainer.find('.other-selection-container'),
							specialKnowledge,
							moduleInfoContainer = $('#special-module-info-container'),
							moduleTabContainer = $('#special-module-tabs'),
							moduleContainer = $('#special-module-container'),
							MAX_MODULE_NUM = 5,
							bindAddContent, specialData, printSpecialData,
							previewContainer = $('#special-preview-container');
						specialData = ${ moduleInfoJson };
						printSpecialData = function(description) {
							console.log(description + ':');
							console.log(JSON.stringify(specialData, null, '\t'));
						};
						printSpecialData('init data');
						// 概述编辑切换
						$('#special-nav-tabs').on('click', 'a', function(e) {
							e.preventDefault();
							$(this).tab('show');
						});
						statisticContainer.on('click', '.btn-save', function(e) {
							var el = $(this),
								data = {},
								validator = new Validator(),
								_like = statisticContainer.find('.special-like'),
								_reply = statisticContainer.find('.special-reply');
							data.id = specialData.id;
							data.praiseCountSys = +_like.val().trim();
							data.shareCountSys= +_reply.val().trim();
							validator.add(data.id, 'isNotEmpty', function() {
								alert('专题id不能为空');
								// TODO 确定逻辑
							}).add(data.praiseCountSys, 'isNaturalNum', function() {
								alert('请输入合法的点赞数');
								_like.val('').focus();
							}).add(data.shareCountSys, 'isNaturalNum', function() {
								alert('请输入合法的转发数');
								_reply.val('').focus();
							});
							if(!validator.start()) {
								return false;
							}
							el.prop('disabled', true);
							ajaxPromise({
								url: window.basePath + 'special/updateSpecialCount',
								type: 'POST',
								data: data,
								dataType: 'json'
							}).then(function(data) {
								alert('保存成功');
								document.location.reload();
							}, function() {
								el.prop('disabled', false);
							});
						});
						// 渲染模块
						moduleContainer.html(tmpl('modules-tmpl', specialData));
						// 修改标题
						baseInfoContainer.find('.special-main-title').on('change', function(e) {
							var el = $(this), title;
							title = el.val().trim();
							if(title.length > 15) {
								alert('标题最多15个字');
								return;
							}
							specialData.title = title;
							printSpecialData('main title change');
						});
						// 专题背景上传
						baseInfoContainer.on('click', '.special-background', function(e) {
							var el = $(this);
							seajs.use('module/ImgInput', function(imgInput) {
								$(document).one('ImgInput:insert', function(e, imageInfo) {
									el.attr({
										'src': imageInfo.imageUrl
									});
									specialData.banner = imageInfo.imageUrl;
									printSpecialData('banner change');
								}).one('ImgInput:hide', function(e) {
									$(document).off('ImgInput:insert');
								});
								imgInput.show('image-input');
							});
						}).on('click', '.btn-save-special', function(e) {
							var el = $(this), data = {}, validator;
							data.title = specialData.title;
							data.titleUrl = specialData.banner;
							data.content = specialData.description;
							data.type = baseInfoContainer.find('[name="special-type"]').filter(':checked').val();
							validator = new Validator();
							validator.add(data.title, 'isNotEmpty', function() {
								alert('标题不能为空');
							}).add(data.title, 'maxLength:15', function() {
								alert('标题最多15字');
							}).add(data.titleUrl, 'isNotEmpty', function() {
								alert('背景图片不能为空');
							}).add(data.content, 'isNotEmpty', function() {
								alert('介绍不能为空');
							}).add(data.content, 'maxLength:90', function() {
								alert('介绍最多90字');
							});
							if(data.type === '0') {
								data.gradeIdArray = baseInfoContainer.find('[name="special-grade"]').filter(':checked').map(function() {
									return $(this).val();
								}).get();
								data.subjectIdArray = baseInfoContainer.find('[name="special-subject"]').filter(':checked').map(function() {
									return $(this).val();
								}).get(); 
								data.knowledge = specialKnowledge.getKnowledges();
								validator.add(data.knowledge, 'minLength:1', function() {
									alert('至少添加一个知识点');
								});
								data.knowledge = data.knowledge.join();
							} else {
								data.gradeIdArray = baseInfoContainer.find('[name="special-grades"]').filter(':checked').map(function() {
									return $(this).val();
								}).get();
								data.subjectIdArray = baseInfoContainer.find('[name="special-subjects"]').filter(':checked').map(function() {
									return $(this).val();
								}).get();
							}
							validator.add(data.gradeIdArray, 'minLength:1', function() {
								alert('至少选择一个年级');
							}).add(data.subjectIdArray, 'minLength:1', function() {
								alert('至少选择一个学科');
							});
							data.gradeIdArray = data.gradeIdArray.join();
							data.subjectIdArray = data.subjectIdArray.join();
							data.id = specialData.id;
							if(!validator.start()) {
								return;
							}
							el.prop('disabled', true);
							ajaxPromise({
								url: window.basePath + 'special/updateSpecial',
								type: 'POST',
								data: data,
								dataType: 'json'
							}).then(function(data) {
								alert('保存成功');
								specialData.id = data.result.id;
								el.prop('disabled', false);
							}, function() {
								el.prop('disabled', false);
							});
						});
						// 修改介绍
						baseInfoContainer.find('.special-description').on('change', function(e) {
							var el = $(this), description;
							description = el.val().trim();
							if(description.length > 500) {
								alert('介绍不能多于500字');
								return false;
							}
							specialData.description = description;
							printSpecialData('description change');
						});
						// 专题类型切换
						baseInfoContainer.find('[name="special-type"]').on('change', function(e) {
							var el = $(this);
							if(el.val() === '1') {
								knowledgeSelectionContainer.hide();
								otherSelectionContainer.show();
							} else {
								otherSelectionContainer.hide();
								knowledgeSelectionContainer.show();
							}
						});
						specialKnowledge = new Knowledge('knowledge-container', {
							getGrade: function() {
								return knowledgeSelectionContainer.find('[name="special-grade"]').filter(':checked').val();
							},
							getSubject: function() {
								return knowledgeSelectionContainer.find('[name="special-subject"]').filter(':checked').val();
							}
						});
						// 切换年级学科清除知识点
						knowledgeSelectionContainer.find('[name="special-grade"]').add(knowledgeSelectionContainer.find('[name="special-subject"]')).on('change', function(e) {
							specialKnowledge.clear();
						});
						addEvent = (function() {
							var content, selectors;
							content = [
								[
									'<div class="form-group">',
										'<label>图文</label>',
										'<label class="pull-right">',
											'<a href="#" class="modify-text">修改</a>',
										'</label>',
										'<div class="module-item module-item-text"></div>',
									'</div>'
								].join(''),
								[
									'<div class="form-group has-feedback" data-type="1">',
										'<div class="ui-input-group">',
											'<span class="ui-input-group-addon">讲解</span>',
											'<input type="text" placeholder="请填写讲解ID" class="form-control module-item module-item-media">',
										'</div>',
										'<span class="glyphicon glyphicon-ok form-control-feedback module-item-validate"></span>',
									'</div>'
								].join(''),
								[
									'<div class="form-group has-feedback" data-type="2">',
										'<div class="ui-input-group">',
											'<span class="ui-input-group-addon">习题集</span>',
											'<input type="text" placeholder="请填写习题集ID" class="form-control module-item module-item-exercise">',
										'</div>',
										'<span class="glyphicon glyphicon-ok form-control-feedback module-item-validate"></span>',
									'</div>'
								].join(''),
								[
									'<div class="form-group has-feedback" data-type="3">',
										'<div class="ui-input-group">',
											'<span class="ui-input-group-addon">老师</span>',
											'<input type="text" placeholder="请填写老师手机号" class="form-control module-item module-item-teacher">',
										'</div>',
										'<span class="glyphicon glyphicon-ok form-control-feedback module-item-validate"></span>',
									'</div>'
								].join('')
							];
							selectors = ['.module-item-text', '.module-item-media', '.module-item-exercise', '.module-item-teacher'];
							return function(container) {
								container.find('.add-content').on('change', function(e) {
									var el = $(this), type = el.val(), curItem, typeData,
										itemContainer;
									if(type !== '') {
										type = +type;
										itemContainer = container.find('.module-item-container');
										if(itemContainer.find(selectors[type]).length >= 5) {
											alert('一个模块中同类型内容已达上限');
											el.val('');
											return false;
										}
										curItem = $(content[type]).appendTo(itemContainer);
										typeData = {
											type: type
										};
										if(type === 0) {
											typeData.content = '';
											RichTextDialog.show('rich-text-dialog', {
												callback: function(data) {
													curItem.find('.module-item').html(data.content);
													specialData.sections[container.index()].chapters[curItem.index()].content = data.content;
												}
											});
										} else {
											curItem.find('.module-item').focus().on('change', function(e) {
												curItem.removeClass('has-success');
												specialData.sections[container.index()].chapters[curItem.index()] = {
													type: type,
													invalid: 1
												};
											});
											typeData.invalid = 1;
										}
										specialData.sections[container.index()].chapters.push(typeData);
										printSpecialData('add type, ' + type);
									}
									el.val('');
								});
								container.find('.special-module-title').on('change', function(e) {
									var el = $(this), title;
									title = el.val().trim();
									if(title.length > 15) {
										alert('标题最多15个字');
										return false;
									}
									specialData.sections[container.index()].title = title;
									printSpecialData('module title change');
								});
								container.find('.module-item-media, .module-item-exercise, .module-item-teacher').on('change', function(e) {
									var el = $(this), curItem;
									curItem = el.closest('.form-group').removeClass('has-success');
									specialData.sections[container.index()].chapters[curItem.index()] = {
										type: curItem.data('type'),
										invalid: 1
									};
								});
							};
						}());
						// 绑定添加内容事件
						moduleContainer.children().each(function() {
							addEvent($(this));
						});
						// 模块tab切换
						moduleTabContainer.on('click', 'a', function(e) {
							e.preventDefault();
							$(this).tab('show');
						}).on('click', '.add-module', function(e) {
							var el = $(this),
								curTabNum = el.siblings().length,
								newTabId, curContainer;
							if(curTabNum >= MAX_MODULE_NUM) {
								alert('最多只能添加' + MAX_MODULE_NUM + '个模块');
								return false;
							}
							newTabId = Date.now();
							el.before(tmpl('module-tab-tmpl', {
								id: newTabId,
								num: curTabNum + 1
							}));
							curContainer = $(tmpl('new-module-tmpl', {
								id: newTabId,
								status: specialData.status
							})).appendTo(moduleContainer);
							moduleTabContainer.find('a[href="#special-module' + newTabId + '"]').tab('show');
							addEvent(curContainer);
							specialData.sections.push({
								id: '',
								title: '',
								chapters: [
									{
										type: 0,
										content: ''
									}
								]
							});
							printSpecialData('add module');
						}).on('click', '.remove-module', function(e) {
							var el = $(this).closest('a'), moduleId, curTab, curModule, curModuleData, curModuleId, nearTab, nearModule;
							e.stopImmediatePropagation();
							e.preventDefault();
							if(!confirm('确认删除当前模块')) {
								return false;
							}
							curTab = el.closest('li');
							if(curTab.siblings.length === 1) {
								alert('至少保留一个模块');
								return false;
							}
							moduleId = el.attr('href');
							curModule = $(moduleId);
							if(curTab.hasClass('active')) {
								nearTab = curTab.prev();
								nearModule = curModule.prev();
								if(nearTab.length === 0) {
									nearTab = curTab.next();
									nearModule = curModule.next();
								}
								nearTab.find('a').tab('show');
								nearModule.addClass('active in'); 
							}
							// 删除模块
							curModuleData = specialData.sections.splice(curModule.index(), 1);
							curModuleId = curModuleData[0].id;
							printSpecialData('remove module');
							curModule.remove();
							curTab.remove();
							// 更新序号
							moduleTabContainer.find('.module-tab-title').each(function(i) {
								$(this).text('模块' + (i + 1));
							});
							if(curModuleId) {
								ajaxPromise({
									url: window.basePath + 'module/deleteModule',
									type: 'POST',
									data: {
										moduleId: curModuleId
									},
									dataType: 'json'
								});
							}
						});
						// 双击删除内容
						moduleInfoContainer.on('dblclick', '.module-item', function(e) {
							var el = $(this), curItem, curModule;
							if(el.data('lock')) {
								return false;
							}
							if(!confirm('确认删除当前内容')) {
								return false;
							}
							curItem = el.closest('.form-group');
							curModule = curItem.closest('.special-module');
							// 删除dom节点
							specialData.sections[curModule.index()].chapters.splice(curItem.index(), 1);
							printSpecialData('remove item');
							curItem.remove();
						});
						// 编辑图文
						moduleInfoContainer.on('click', '.modify-text', function(e) {
							var curItem = $(this).closest('.form-group'), curModule = curItem.closest('.special-module'), container = curItem.find('.module-item-text');
							e.preventDefault();
							// 编辑图文登录框
							RichTextDialog.show('rich-text-dialog', {
								content: container.html(),
								callback: function(data) {
									container.html(data.content);
									specialData.sections[curModule.index()].chapters[curItem.index()].content = data.content;
									printSpecialData('rich text content change');
								}
							});
						}).on('click', '.module-item-validate', function(e) {
							var el = $(this), curItem, curModule, validator, id;
							if(el.data('sent')) {
								return false;
							}
							curItem = el.closest('.form-group');
							if(curItem.hasClass('has-success')) {
								return false;
							}
							curModule = el.closest('.special-module');
							id = curItem.find('.module-item').val().trim();
							validator = new Validator();
							switch(curItem.data('type')) {
								// 讲解
								case 1:
									validator.add(id, 'isNotEmpty', function(e) {
										alert('讲解id不能为空');
									});
									if(!validator.start()) {
										return false;
									}
									el.data('sent', 1);
									// 验证讲解, 更新json
									ajaxPromise({
										url: window.basePath + 'audio/getAudioInfoJson',
										type: 'GET',
										data: {
											audioId: id
										},
										dataType: 'json'
									}).then(function(data) {
										var container = $('<div>');
										// 题目容错
										if(data.result) {
											data.result.questionStem = container.html(data.result.questionStem).html();
										}
										$.extend(specialData.sections[curModule.index()].chapters[curItem.index()], {
											result: data.result,
											invalid: 0
										});
										curItem.addClass('has-success');
										el.data('sent', 0);
									}, function() {
										el.data('sent', 0);
									});
									break;
								// 习题集
								case 2:
									validator.add(id, 'isNotEmpty', function(e) {
										alert('习题集id不能为空');
									});
									if(!validator.start()) {
										return false;
									}
									el.data('sent', 1);
									// 验证习题集，更新json
									ajaxPromise({
										url: window.basePath + 'audioSet/getAudioSetInfoJson',
										type: 'GET',
										data: {
											audioSetId: id
										},
										dataType: 'json'
									}).then(function(data) {
										if(!data.result.isFree) {
											alert('非免费的习题集不允许添加到专题');
										} else {
											$.extend(specialData.sections[curModule.index()].chapters[curItem.index()], {
												result: data.result,
												invalid: 0
											});
											curItem.addClass('has-success');
										}
										el.data('sent', 0);
									}, function() {
										el.data('sent', 0);
									});
									break;
								// 教师
								case 3:
									validator.add(id, 'mobileFormat', function(e) {
										alert('请输入合法的手机号码');
									});
									if(!validator.start()) {
										return false;
									}
									el.data('sent', 1);
									// 验证教师，更新json
									ajaxPromise({
										url: window.basePath + 'teacher/getTeacherInfoJson',
										type: 'GET',
										data: {
											teacherPhoneNumber: id
										},
										dataType: 'json'
									}).then(function(data) {
										$.extend(specialData.sections[curModule.index()].chapters[curItem.index()], {
											result: data.result,
											invalid: 0
										});
										curItem.addClass('has-success');
										el.data('sent', 0);
									}, function() {
										el.data('sent', 0);
									});
									break;
								
								default:
									// noop
							}
						}).on('click', '.btn-save-module', function(e) {
							var el = $(this), curModule, prevModuleId, i, len,
								validator, data = {}, curIndex, moduleInfo, moduleContent;
							validator = new Validator();
							data.specialId = specialData.id;
							validator.add(data.specialId, 'isNotEmpty', function() {
								alert('请先保存专题');
							});
							curModule = el.closest('.special-module');
							curIndex = curModule.index();
							if(curIndex > 0) {
								prevModuleId = specialData.sections[curIndex - 1].id;
								validator.add(prevModuleId, 'isNotEmpty', function() {
									alert('请先保存之前的模块');
								});
							}
							moduleInfo = specialData.sections[curIndex];
							data.moduleTitle = moduleInfo.title;
							validator.add(data.moduleTitle, 'isNotEmpty', function() {
								alert('模块标题不能为空');
							}).add(data.moduleTitle, 'maxLength:15', function() {
								alert('模块标题不能超过15个字');
							});
							if(!validator.start()) {
								return;
							}
							
							moduleContent = moduleInfo.chapters;
							if(moduleContent.some(function(o, i) {
								return o.type === 0 && o.content === '';
							})) {
								alert('图文内容不能为空');
								return;
							}
							data.dataJson = [];
							if(moduleContent.some(function(o, i) {
								var type = o.type, flag;
								flag = type !== 0 && o.invalid;
								if(flag) {
									return flag;
								}
								if(type === 2 || type === 3) {
									data.dataJson.push({
										type: type,
										id: o.result.id,
										content: o.result.name || o.result.phoneNum
									});
								}
								return flag;
							})) {
								alert('请验证相关数据');
								return;
							}
							data.moduleArray = [];
							specialData.sections.every(function(o) {
								data.moduleArray.push(o.id);
								return o.id !== '';
							});
							data.moduleArray = data.moduleArray.join();
							data.dataJson = JSON.stringify(data.dataJson);
							data.moduleId = moduleInfo.id;
							data.moduleContent = JSON.stringify(moduleContent);
							el.prop('disabled', true);
							ajaxPromise({
								url: window.basePath + 'module/updateModule',
								type: 'POST',
								data: data,
								dataType: 'json'
							}).then(function(data) {
								if(moduleInfo.id === '') {
									moduleInfo.id = data.result.id;
								}
								alert('该模块已保存成功');
								el.prop('disabled', false);
							}, function() {
								el.prop('disabled', false);
							});
						});
						// 预览
						previewContainer.on('click', '.btn-preview', function(e) {
							var el = $(this);
							if(el.data('preview')) {
								return;
							}
							previewContainer.find('.preview-zone').html(tmpl('preview-tmpl', specialData));
							el.data('preview', 1);
							setTimeout(function() {
								el.data('preview', 0);
							}, 1000);
						});
					});
				}
			});
		</script>
	</body>
</html>