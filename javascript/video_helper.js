// need zhQuery
// 为 video 元素添加 速度控制和全屏按钮
var videoHelper = {
    // 选定元素，pos指定在内部还是在后面添加视频控制元素
    // cssSelector 为空时，直接在video后面添加
    addSpeeder:function(cssSelector, pos){
        var videoEle = this.findVideo();
        if(videoEle != null){
            zh.l('zhao dao video');
            var btnsEle = this.createBtns(videoEle);
            if(cssSelector != null && cssSelector != ""){
                var posEle = zh.q(cssSelector);
                zh.addEle(btnsEle, posEle, pos);
            }else{
                zh.addEle(btnsEle, videoEle, 'after');

            }

        }

    },
    findVideo:function(){
        var videoEle = zh.q('video');
        if(videoEle != null){
            return videoEle;
        }
        var frameEles = zh.qa('iframe');
        frameEles.forEach(function(fEle){
            //console.log("查找video",fEle);
            var fDoc = fEle.contentDocument;
            var videoE = zh.q('video', fDoc);
            if(videoE != null){
                videoEle = videoE;
                fEle.setAttribute('allowFullScreen','');
            }
        });
        return videoEle;
    },
    createBtns:function(videoEle){
        var container = zh.c('div');
        var btnMinus = zh.c('button', '-', container);
        var btn05 = zh.c('button', '0.5', container);
        var btn10 = zh.c('button', '1.0', container);
        var btn15 = zh.c('button', '1.5', container);
        var btn20 = zh.c('button', '2.0', container);
        var btnPlus = zh.c('button','+', container);
        var span01 = zh.c('span', '速度:', container);
        var span02 = zh.c('span', '1.0', container);
        var fullScreen = zh.c('button', 'FullScreen', container);


        var speedFun = function(baseSpeed, delta){
            var newFun = function(){
                var speed = baseSpeed == 0 ? videoEle.playbackRate + delta : baseSpeed;
                videoEle.playbackRate = speed;
                span02.innerHTML = speed;
            }
            return newFun;
        };


        var fullScreenFun = function (ele) {
            var el = ele;
            var rfs = el.requestFullScreen || el.webkitRequestFullScreen || el.mozRequestFullScreen || el.msRequestFullScreen;
            if (typeof rfs != "undefined" && rfs) {
                rfs.call(el);
            } else if (typeof window.ActiveXObject != "undefined") {
                // for Internet Explorer
                var wscript = new ActiveXObject("WScript.Shell");
                if (wscript != null) {
                    wscript.SendKeys("{F11}");
                }
            }
        }

        btnMinus.onclick=speedFun(0, -0.1);
        btn05.onclick=speedFun(0.5);
        btn10.onclick=speedFun(1.0);
        btn15.onclick=speedFun(1.5);
        btn20.onclick=speedFun(2.0);
        btnPlus.onclick=speedFun(0, 0.1);
        fullScreen.onclick = function(){
            fullScreenFun(videoEle);
        }
        return container;
    }
}