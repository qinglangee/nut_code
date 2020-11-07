// need zhQuery

// 查找阅读更多元素并点击
var readMore = {
    open:function(btnSelector){
        var btn = zh.q(btnSelector);
        if(btn != null){
            btn.click();
        }

    }
}