/**
* 提供几个功能函数
* zh.q(cssSelector, parent);  返回第一个符合条件的节点
* zh.qa(cssSelector, parent);  返回所有符合条件的节点
* zh.l();  console.log()
* zh.c(param, html, parent);  // create Element
* zh.p(html, parent); //  parse html 
* zh.addEle(newEle, posEle, pos);  // pos 有 before after append
* 
* 
*/

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
    },
    p:function(html, parent){
        // parse html ,创建一个元素
        var div = document.createElement("div");
        div.innerHTML = html;
        var ele = div.children[0];
        if(parent != null){
            parent.appendChild(ele);
        }
        return ele;
    },
    addEle:function(newEle, posEle, pos){
        // newEle 要添加的元素
        // posEle 定位元素，pos 指定在什么位置加 前 before、后 after、内部 append
        if(pos == 'before'){
            posEle.parentNode.insertBefore(newEle, posEle);
        }else if(pos == 'append'){
            posEle.appendChild(newEle);
        }else{
            posEle.parentNode.insertBefore(newEle,posEle.nextSibling);
        }
    }

}