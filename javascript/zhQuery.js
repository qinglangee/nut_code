var zh={
    q:function(cssSelector, ele){ // 返回符合条件的第一个节点
        if(ele == null){
            ele = document;
        }
        return ele.querySelector(cssSelector);
    },
    qa:function(cssSelector, ele){ // 返回符合条件的所有节点
        if(ele == null){
            ele = document;
        }
        return ele.querySelectorAll(cssSelector);
    },
    l:function(msg1){
        console.log(msg1);
    },
    c:function(param, html, parent){
        // 创建控件，可以顺便设置 innerHTML 和 放入父节点
        var ele = document.createElement(param);
        if(html != null && html != ""){
            ele.innerHTML = html;
        }
        if(parent != null){
            parent.appendChild(ele);
        }
        return ele;
    }

}