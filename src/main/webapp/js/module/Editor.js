/**
 * @description  题库编辑器
 * @author lishunping(lishunping@xuexibao.cn)
 */
define('module/Editor', ['lib/jquery', 'util/artTemplate'], function(require) {
	'use strict';
	var $ = require('lib/jquery'),
		Editor,
		latexContainer = $('<div>'),
		basePath = window.basePath || '',
		doc = document,
		tmpl = require('util/artTemplate');
	/**
	 * @constructor 编辑器
	 * @param {String|jQuery} id 编辑器id或jquery对象
	 * @param {Object} config 扩展参数
	 * @config {Function} submitCall 提交回调
	 * @config {String} imgClass 插入图片classname
	 * @example
	 * 		seajs.use(['module/Editor'], function(Editor) {
	 * 			var editor = new Editor('id', {
	 * 				submitCall: function() {
	 * 				
	 * 				},
	 * 				imgClass: 'special-illustration'
	 * 			});
	 * 		});
	 */
	Editor = function(id, config) {
		var Self = this;
		config = config || {};
		if($.type(id) === 'string') {
			Self._body = $('#' + id);
		} else {
			Self._body = id;
		}
		$.extend(Self, config);
		Self.init();
	};
	Editor.prototype = {
		/**
		 * 选择题模板
		 * @type {Function}
		 */
		tmpl: tmpl.compile([
			'{{#description}}',
			'<table>',
				'<tbody>',
					'{{each choices}}',
					'{{if $index % num === 0}}',
					'<tr>',
					'{{/if}}',
						//均匀布局
						'<td style="width:{{100 / num}}%">{{$index | capitalAlpha}}.{{#$value}}</td>',
					'{{if $index % num === num - 1 || $index === choices.length}}',
					'</tr>',
					'{{/if}}',
					'{{/each}}',
				'</tbody>',
			'</table>'
		].join('')),
		/**
		 * 初始化入口
		 */
		init: function() {
			var Self = this;
			Self.editContainer = Self._body.find('.edit-border');
			Self.area = Self.editContainer.find('.edittable');
			Self.submit = Self._body.find('.submit-btn');
			Self.curEditArea = Self.area;
			Self.addEvent();
		},
		/**
		 * 激活
		 * @example
		 * 		seajs.use(['module/Editor'], function(Editor) {
		 * 			var eidtor = new Editor('id');
		 * 			editor.enable();
		 * 		});
		 */
		enable: function() {
			var Self = this;
			Self._body.data('status', 'edit');
			Self.editContainer.children().show();
			Self.submit.text('修改' + Self.submit.data('title')).removeClass('submit-preview').data('status', '');
		},
		/**
		 * 禁用
		 * @param {Object} config 配置参数
		 * @config {String} [text] 按钮文案
		 * @config {Number|String} [submitStatus] 提交状态
		 * @example
		 * 		seajs.use(['module/Editor'], function(Editor) {
		 * 			var eidtor = new Editor('id');
		 * 			editor.disable();
		 * 		});
		 */
		disable: function(config) {
			var Self = this;
			config = config || {};
			if(config.text === undefined) {
				config.text = '修改' + Self.submit.data('title');
			}
			Self._body.data('status', 'preview');
			Self.editContainer.children().hide();
			Self.submit.text(config.text).addClass('submit-preview');
			if(config.submitStatus) {
				Self.submit.data('status', config.submitStatus);
			}
		},
		/**
		 * 获取内容
		 * @param  {Object} config 配置参数
		 * @config {Boolean} withLatex 返回latex
		 * @return {Promise} 获取内容promise
		 * @example
		 * 		seajs.use(['module/Editor'], function(Editor) {
		 * 			var eidtor = new Editor('id');
		 * 			editor.getContent({
		 * 				withLatex: 1
		 * 			}).then(function(data) {
		 * 				console.log(data.choices);
		 * 				console.log(data.content);
		 * 				console.log(data.latex)
		 * 			});
		 * 		});
		 */
		getContent: function(config) {
			var Self = this, generateContent;
			config = config || {};
			generateContent = function() {
				var choiceList, data = {};
				data.description = Self.area.html();
				choiceList = Self.editContainer.find('.choice-item');
				if(choiceList[0]) {
					data.choices = choiceList.map(function() {
						return $(this).html();
					}).get();
					data.description = data.description;
					data.content = Self.tmpl({
						description: data.description,
						choices: data.choices,
						num: +Self._body.find('.choice-num').val().trim() || 1
					});
					data.content = latexContainer.html(data.content).html();
				} else {
					data.content = data.description;
				}
				if(config.withLatex) {
					if(data.content) {
						latexContainer.html(data.content).find('.formula').each(function() {
							var formula = $(this);
							formula.after('<span class="latex">' + formula.data('latex') + '</span>');
						});
						data.latex = latexContainer.text();
					} else {
						data.latex = '';
					}
				}
				return data;
			};
			if(config.noRemote) {
				return generateContent();
			}
			return new Promise(function(resolve, reject) {
				require.async('util/localizeImg', function(localizeImg) {
					localizeImg(Self.editContainer.find('img')).then(function(errorFlag) {
						if(!errorFlag) {
							resolve(generateContent());
						}
					});
				});
			});
		},
		/**
		* 绑定事件
		*/
		addEvent: function() {
			var Self = this, _body;
			_body = Self._body;
			Self.area.on('focus', function(e) {
				Self.curEditArea = $(this);
			});
			_body.find('.choice-item').on('focus', function(e) {
				Self.curEditArea = $(this);
			});
			_body.on('click', '.tool-btn', function(e) {
				var el = $(this), command, param;
				if(_body.data('status') === 'preview') {
					// 阻止后序事件
					e.stopImmediatePropagation();
					alert('当前编辑窗口为不可编辑状态！');
					return;
				}
				command = el.data('command');
				if(command) {
					param = el.data('param');
					param = param || null;
					doc.execCommand(command, false, param);
				}
			}).on('click', '.insert-img', function(e) {
				require.async('module/ImgInput', function(imgInput) {
					var placeholder;
					Self.curEditArea.focus();
					document.execCommand('insertimage', false, basePath + 'image/edit/img.png');
					placeholder = Self.curEditArea.find('img[src$="image/edit/img.png"]');
					if(Self.imgClass) {
						placeholder.addClass(Self.imgClass);
					}
					$(document).one('ImgInput:insert', function(e, imageInfo) {
						placeholder.attr({
							'src': imageInfo.imageUrl,
							'data-width': imageInfo.width,
							'data-height': imageInfo.height
						}).data('img', 1);
					}).one('ImgInput:hide', function(e) {
						var flag = placeholder.data('img');
						if(!flag) {
							placeholder.remove();
							// 手动释放内存
							placeholder = null;
							$(document).off('ImgInput:insert');
						}
					});
					imgInput.show('image-input');
				});
			}).on('click', '.insert-formula', function(e) {
				require.async('module/FormulaInput', function(formulaInput) {
					formulaInput.show('formula-input', Self.curEditArea);
				});
			}).on('click', '.delete-style', function(e) {
				if(confirm('确定要清空当前编辑区的内容?')) {
					Self.curEditArea.empty();
				}
			}).on('click', '.add-choice', function(e) {
				// 添加选项
				var choiceList = Self.editContainer.find('.choice-list'), choice, hasList;
				hasList = !!choiceList[0];
				if(!hasList) {
					choiceList = $('<ol class="choice-list"></ol>');
				}
				choice = $('<li class="choice-item" contenteditable></li>').appendTo(choiceList);
				if(!hasList) {
					Self.editContainer.append(choiceList);
				}
				// 自动聚焦
				choice.on('focus', function(e) {
					Self.curEditArea = $(this);
				}).focus();
			}).on('dblclick', '.choice-item', function(e) {
				var el = $(this);
				if(confirm('确定要删除该选项？')) {
					el.off('focus');
					if(el.siblings().length === 0) {
						el.parent().remove();
					} else {
						el.remove();
					}
				}
			}).on('click', '.submit-btn', function(e) {
				var el = $(this),
					title = el.data('title'),
					content;
				if(_body.data('status') === 'preview') {
					Self.enable();
				} else {
					if(Self.submitCall) {
						Self.submitCall();
					}
				}
			});
		}
	};
	return Editor;
});