mydb = db.getSisterDB("dovebox");
var mm=["aa","bb"];
mydb.dashboard_basic.remove();
for(i=0;i<14;i++){
  var type=i%3;
  var con="nothing";
  if(type==0){con="ppp\"&quot;zhongjiandep&quot;\"idfd"}
  mydb.dashboard_basic.insert({dashboardAbstract:con});
}
