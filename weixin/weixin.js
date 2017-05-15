// 总人数：181 未包含人数：14

$(".ng-scope")[0].removeEventListener( "DOMMouseScroll", scroll01, false );
var friends={}; // 所有好友
var oldCount = 0; // 计数器，向下滚动没有新增好友时加1
var tags={}; // 保存现有标签内容 

String.prototype.Trim = function()  { 
	return this.replace(/(^\s*)|(\s*$)/g, ""); 
} 

// 滚动结束时， 打印结果 
function scrollEnd(){
	console.log("scrollEnd start.")
	var friendList = [];
	for(friend in friends){
		friendList.push(friend);
	}

	var str = "";
	for(i=0;i<friendList.length;i++){
		var name = friendList[i];
		str += "\n" + name;
	}
	// 打印所有的名字
	console.log(str);

	// 初始化标签中的人
	var tagFriends = {};
	for(tagName in tags){
		var tagArr = tags[tagName];
		for(i in tagArr){
			tagFriends[tagArr[i]] = 1;
		}
	}

	// 输出不在标签中的结果
	var outTagStr = "";
	var outCount = 0;
	for(i in friendList){
		//console.log("abcd   " + friendList[i]);
		var userName = friendList[i];
		if(tagFriends[userName] == null){
			outTagStr += "\n" + userName;
			outCount ++;
		}
	}
	console.log("outTagStr is:" + outTagStr);

	console.log("总人数：" + friendList.length + " 未包含人数：" + outCount);
}

// 滚动时的处理
function scroll01(){
	var newCount = 0;
	$(".contact_item  h4").each(function(){
		var ele = $(this);
		var text = ele.text().replace("️",""); // 初心小青
		text = text.replace("🍤",""); // 发么斯
		text = text.trim();
		//console.log(text);
		if(friends[text] == null){
			newCount++;
			oldCount = 0;
			friends[text] = 1;
			// 改过的名字
			if(text != ele.text()){
				console.log("====================wrong name:" + text + "[-]" + ele.text());
			}
		}
	});

	// 连续没有新增的就算是到底了
	if(newCount == 0){
		oldCount++;
		console.log("oldCount:" + oldCount);
	}
	if(oldCount == 20){
		scrollEnd();
	}
}

//  绑定滚动事件，在 firefox 中运行
$(".ng-scope")[0].addEventListener( "DOMMouseScroll", scroll01, false );

function initTags(){
	tags={
		"姑娘们":["*mozzie*","memory","柯伊lucky","Sophie","耿小胖儿","李宇恒","倪玉霏","真爱","止。","姜微哲","lluolluo"
			,"周凡凡","喵喵喵喵喵喵"],
		"百合":["欧阳萌萌","美娜","Lsabal","雯雯","梦洁","倩倩","小兰"],
		"平板支撑":["Allison"],
		"家里人":["徐 尼克","张守君","Malloc","老狙","快乐(云)","超级马力噢","秋大","DaKer"],
		"朋友家属":["大小的六","szq","szz","他爹",""],
		"大学同学":["刘磊","龙旋风","于雨","小川","deco.chen","Fishing先生","粒粒","静默","郝香山","亚瑟王","solotraveler","A-战歌"
			,"李明遥@银商电子","七筒"],
		"搜前途":["Peter","Ms.F","Liz","桃子","阿","古海叶","NY19","张志平01","张志平02","Chen","老实人","天之美禄","赵善雨Do"
			,"建宇","鱼丸","刘俊杰","MY孟洋","ison.x","刘雪飞"],
		"前同事":["Lifeix立方设计","lee_","王凤娇","Neo","Anwj","李江","厨子","嘎嘣脆","我要很好","泽蛋","王飞","josh","范海春","邹静","叶"
			,"令狐少侠","lee黎志刚","李志明","旭日生空","沙水","pengkw","James","张玉龙","蔡婧","不再聊天","ZYB","Jackie","黄东","土豆","Cising"
			,"异次元","黄奖","nostory","发嚒斯","Dodo","夏劲松","蕓馨","立读文化小编","果然","邓鸿飞","刘新建","提笔忘字","陈尉","陈亮_Leo","huanyi"
			,"寒露","王文霞","徐宁Jack","王闶","taketoheart","兜圈圈","简单生活","阿P","EmilyXie","九 尾","沫沫","萧雨萱","戚继臻"],
		"房产中介":["奔跑2016"],
		"其它":["安迪团队","林佳怡","贝咔贝咔","Andy","晓哥_恋爱补习班 校长","PUANEY团队倪•NEY约会教练","爱尚你","真爱","童姥","Tosee涂涂"
			,"芳芳","东城","小不点","李迪（情感咨询 自媒体人）","浪迹教育@饺子"
			,"元义","浪迹教育私教负责人  老佟","代码家","小小智","无风","（证劵 资金 虚拟）导师","AAA金牌网店导师小史"
			,"佟售后号","浪子内部报名号","尧大","浪迹","Provence","老佟答疑号","L ，","浪哥  服装穿搭号","Shirley～乔"
			,"撩神老吴『工作答疑报名号』","cckk苏苏","初心小青","李楠","Alfred","桃之夭夭","小不点","Yuan附近","驾照渔樵"],
		"高中同学":["如风-青岛不认识","memory","吕双志","Ray Wang","任佐民","庞庞"]
	};
}

initTags();

