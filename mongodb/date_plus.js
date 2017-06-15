
// 日期的增加和减少
mydb = db.getSisterDB("leadread");
var cursor = mydb.post.find({hot:0},{create_at:1,update_at:1});
while(cursor.hasNext()){
    var doc = cursor.next();
    var newDate = new Date(doc.create_at.getTime() - 1000*3600*24*10);
    var upDate = new Date(doc.update_at.getTime() + 1000 *3600);
    print(doc.create_at, newDate);
    mydb.post.update({"_id":doc._id},{$set:{create_at:newDate, update_at:upDate}});
}