function format(fmt, date){ //author: meizz   
  var o = {   
    "M+" : date.getMonth()+1,                 //月份   
    "d+" : date.getDate(),                    //日   
    "h+" : date.getHours(),                   //小时   
    "m+" : date.getMinutes(),                 //分   
    "s+" : date.getSeconds(),                 //秒   
    "q+" : Math.floor((date.getMonth()+3)/3), //季度   
    "S"  : date.getMilliseconds()             //毫秒   
  };   
  if(/(y+)/.test(fmt))   
    fmt=fmt.replace(RegExp.$1, (date.getFullYear()+"").substr(4 - RegExp.$1.length));   
  for(var k in o)   
    if(new RegExp("("+ k +")").test(fmt))   
  fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));   
  return fmt;   
}

mydb = db.getSisterDB("leadread");
var cursor = mydb.data.find({},{create_at:1});
var map = {};
while(cursor.hasNext()){
    var doc = cursor.next();
    var str = {$dateToString: { format: "%Y-%m-%d", date: doc.create_at }};
    date = format("yyyy-MM-dd", doc.create_at);
    if(map[date]==null){
        map[date] = 1;
    }else{
        map[date] = map[date] + 1;
    }
}
for(field in map){
    print(field + " : " + map[field]);
}