define('module/RichTextDialog', ['lib/jquery', 'module/Dialog', 'module/Editor'], function(require) {
	var $ = require('lib/jquery'),
		Dialog = require('module/Dialog'),
		Editor = require('module/Editor'),
		RichTextDialog, instance;
	RichTextDialog = function(id) {
		var Self = this;
		if(instance) {
			return instance;
		}
		if(!(Self instanceof RichTextDialog)) {
			return new RichTextDialog(id);
		}
		Self.dialog = new Dialog(id);
		Self.id = id;
		instance = Self;
	};
	RichTextDialog.prototype = {
		show: function(config) {
			var Self = this, content;
			config = config || {};
			content = config.content || '';
			Self.dialog.show({
				sizeClass: 'modal-lg',
				title: '图文编辑',
				content: [
					'<div id="edit-rich-text" class="edit-box">',
						'<div class="edit-btns">',
							'<ul class="tr-bar">',
								'<ul class="tr-group">',
									'<li class="tr-btn tool-btn insert-img" title="插入图片" data-command="" data-param="">',
										'<input type="button">',
									'</li>',
									'<li class="tr-btn tool-btn insert-formula" title="插入公式" data-command="" data-param="">',
										'<input type="button">',
									'</li>',
								'</ul>',
							'</ul>',
						'</div>',
						'<div class="edit-border">',
							'<div class="edittable" contenteditable="">',
								content,
							'</div>',
						'</div>',
					'</div>'
				].join(''),
				force: 1,
				renderCall: function() {
					var me = this;
					Self.editor = new Editor('edit-rich-text', {
						imgClass: 'special-illustration'
					});
				},
				confirm: function() {
					var me = this;
					Self.editor.getContent().then(function(data) {
						if(config.callback) {
							config.callback(data);
						}
						Self.hide();
						me.enableConfirm();
					});
				}
			});
		},
		hide: function() {
			var Self = this;
			Self.dialog.hide();
		}
	};
	return {
		show: function(id, config) {
			RichTextDialog(id).show(config);
		},
		hide: function(id) {
			RichTextDialog(id).hide();
		}
	}
});