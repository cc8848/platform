define('util/ajaxPromise', ['lib/jquery'], function(require) {
	var $, ajaxPromise;
	$ = require('lib/jquery');
	/**
	 * ajaxPromise工厂
	 * @param  {Object} obj ajax参数与$.ajax一致，但不用配置success error
	 * @param  {Object} config 扩展参数
	 * @config {Boolean} resolveError 是否解决所有数据
	 * @return {Promise}
	 * @example
	 * 		seajs.use('util/ajaxPromise', function(ajaxPromise) {
	 * 			ajaxPromise({
	 * 				url: '',
	 * 				type: 'GET',
	 * 				data: {},
	 * 				dataType: 'json'
	 * 			}, {
	 * 				resolveError: 1
	 * 			}).then(function(data) {
	 * 				// TODO 
	 * 			}, function(errorFlag) {
	 * 				// TODO
	 * 			});
	 * 		});
	 */
	ajaxPromise = function(obj, config) {
		config = config || {};
		return new Promise(function(resolve, reject) {
			obj.success = function(data) {
				if(data.status === 0) {
					resolve(data);
				} else {
					if(config.resolveError) {
						resolve(data);
					} else {
						alert(data.msg);
						reject();
					}
				}
			};
			obj.error = function() {
				alert('网络错误请稍后再试！');
				reject(1);
			};
			$.ajax(obj);
		});
	};
	return ajaxPromise;
});