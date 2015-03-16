mydb = db.getSisterDB("dovebox");
var cursor = mydb.dashboard_basic.find({dashboardAbstract:/&quot;\x22/});
while (cursor.hasNext()) {
    var x = cursor.next();

    /* replace \\n with \n in x's strings ... */
    x.dashboardAbstract=x.dashboardAbstract.replace(/&quot;\"/g,"\"");
    x.dashboardAbstract=x.dashboardAbstract.replace(/\"&quot;/g,"\"");

    mydb.dashboard_basic.update({_id : x._id}, x);
}
