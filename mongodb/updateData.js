
db.ttt.update({type:2},{$set:{commentId:22}})

var ids=[2,3,4,5];
for(i=0;i<ids.length;i++){
    var id = ids[i];
    var temp = db.ttt.findOne({type:id});
    // 先查出数据, 再用它自己的字段更新
    if(temp != null){
        db.ttt.update({type:id},{$set:{commentId:NumberLong(temp.commentId),type:NumberLong(id)}});
    }
}


// 对每条记录进行多个操作
db.ttt.find({type:123}).forEach(
    function(x){
        print(x);
        print(x.a)
    }
)

// 查询, 更新
db.content_basic.find({_id:{$gt:35558015},aid:{$in:[961205,961206]}}).forEach(
    function(x){
        x.load = "[" + x.load + "]";
        db.content_basic.update({_id:x._id}, x);
    }
)

// 正则更新
db.comment.find({content:{$regex:"^emotionId:(\\d+)"}, rootId:8336365}).forEach(function(x){
    var conReg = /emotionId:(\d+)/;
    if(conReg.test(x.content)){
        x.content = '{"emotionId":'+RegExp.$1+'}';
    }
    db.comment.update({"_id":x._id},x);
})

// 随机数据更新
var authors = [];
authors.push({"name" : "小明","avatar" : "http://avatar.l99.com/90x90/d3b/1497257749390_wtz414.jpg","accountId" : NumberLong(53895120),"gender" :1,"longNO" : NumberLong(140473910)});
authors.push({"name" : "小杰","avatar" : "http://avatar.l99.com/90x90/f3d/1497257860670_pqr4s6.jpg","accountId" : NumberLong(53895124),"gender" :1,"longNO" : NumberLong(140473915)});

db.data.find({post_type:{$gt:50000}, author:null}).forEach(function(item){
    var randAuthor = authors[Math.floor(Math.random() * authors.length)];
    db.data.update({"_id":item._id}, {$set:{author:randAuthor}});
});