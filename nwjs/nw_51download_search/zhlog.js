
var fs = require('fs');

zhlog={
	logFilename:"/tmp/aaa",
	logLevel:"log",

	fileLog:function (content){
		var time = new Date().Format("yyyy-MM-dd HH:mm:ss");
		var logContent = time + " " + content;
		fs.appendFile(this.logFilename, logContent, function(err){
			if(err) throw err;
		});
	},

	debug:function (content){
		if(this.logLevel == "debug"){
			var caller = arguments.callee.caller;
			this.fileLog("DEBUG:" + (caller == null ? "zhlog" : caller.name) + " : " + content + "\n");
		}
	},
	log:function (content){
		var caller = arguments.callee.caller;
		this.fileLog("LOG  :" + (caller == null ? "zhlog" : caller.name) + " : " + content + "\n");
	},
	warn:function (content){
		var caller = arguments.callee.caller;
		this.fileLog("WARN : " + (caller == null ? "zhlog" : caller.name) + " : " + content + "\n");
	},
	error:function (content){
		var caller = arguments.callee.caller;
		this.fileLog("ERROR:" + (caller == null ? "zhlog" : caller.name) + " : " + content + "\n");
	},
	init:function(config){
		this.logFilename = config.logFilename;
		if(config.logLevel != null){
			this.logLevel = config.logLevel;
		}
	}
}


/**

* 调用：

*  var time1 = new Date().Format(“yyyy-MM-dd”);
*  var time2 = new Date().Format(“yyyy-MM-dd HH:mm:ss”);
*/
Date.prototype.Format = function (fmt) { //author: meizz 
	var o = {
	    "M+": this.getMonth() + 1, //月份 
	    "d+": this.getDate(), //日 
	    "H+": this.getHours(), //小时 
	    "m+": this.getMinutes(), //分 
	    "s+": this.getSeconds(), //秒 
	    "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	    "S": this.getMilliseconds() //毫秒 
	};
	if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	for (var k in o)
	if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	return fmt;
}



module.exports=zhlog;

// 用法 ：
// 1. import 2. 初始化，制定文件 3. 使用
// var zhlog = require('./zhlog');
// zhlog.init({logFilename:"e:\\temp\\resume_keyword\\51job_async_search\\aaa"});
// zhlog.log(123123);