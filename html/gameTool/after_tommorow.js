// 明日之后
var items = [
{level:1,id:1101,name:"木头"},
{level:1,id:1102,name:"小树枝"},
{level:1,id:1103,name:"植物根茎"},
{level:1,id:1104,name:"梗木藤蔓"},
{level:1,id:1105,name:"树脂"},
{level:1,id:1106,name:"木心"},
{level:1,id:1107,name:"小枝芽"},

{level:1,id:1201,name:"石头"},
{level:1,id:1202,name:"铁矿"},
{level:1,id:1203,name:"锡矿"},
{level:1,id:1204,name:"燧石"},
{level:1,id:1205,name:"硫磺"},
{level:1,id:1206,name:"硝石"},

{level:1,id:1301,name:"麻"},
{level:1,id:1302,name:"麻茎皮"},
{level:1,id:1303,name:"麻茎杆"},
{level:1,id:1304,name:"麻籽"},

{level:1,id:1401,name:"骨头"},
{level:1,id:1402,name:"兽皮"},
{level:1,id:1403,name:"感染血液"},
{level:1,id:1404,name:"爪子"},
{level:1,id:1405,name:"兽筋"},

{level:1,id:1501,name:"石灰"},
{level:1,id:1502,name:"砂岩"},
{level:1,id:1503,name:"胶水"},



{level:2,id:2101,name:"木板", bom:{1101:120, 1102:2}},
{level:2,id:2102,name:"石砖", bom:{1201:120, 1401:2, 1501:1}},
{level:2,id:2103,name:"水泥", bom:{1201:120, 1404:2, 1502:1}},

{level:2,id:2201,name:"生铁", bom:{1202:2, 1102:4}},
{level:2,id:2202,name:"铁铸件", bom:{1203:4, 1202:4, 1106:4}},
{level:2,id:2203,name:"黑火药", bom:{1101:600, 1201:150, 1204:2}},
{level:2,id:2204,name:"六角钉", bom:{2201:2, 1104:4, 1401:2}},
{level:2,id:2205,name:"镙钉", bom:{2202:1, 1107:4, 1304:1, 1205:2}},

{level:2,id:2301,name:"粗布条", bom:{1301:15, 1103:2}},
{level:2,id:2302,name:"布", bom:{2301:1, 1302:1}},
{level:2,id:2303,name:"塑料", bom:{1105:8, 1206:2, 2302:1, 1303:2}},



{level:3,id:3101,name:"建筑一级强化", bom:{2101:2, 2102:1}},
{level:3,id:3102,name:"建筑二级强化", bom:{2101:3, 2102:1, 2103:1}},

{level:3,id:3201,name:"坐便器", bom:{2102:4, 1501:2}},
{level:3,id:3202,name:"武器架", bom:{2101:10, 2204:2}},
{level:3,id:3203,name:"白色皮制沙发", bom:{2101:10, 2302:2, 1503:2}},
{level:3,id:3204,name:"残旧单人床", bom:{2101:10, 2301:2}},
{level:3,id:3205,name:"简陋木桌", bom:{1101:600}},
{level:3,id:3206,name:"洗漱台摆设", bom:{1502:2, 2102:3}},
{level:3,id:3207,name:"简约台灯", bom:{2303:2, 2201:3}},
{level:3,id:3208,name:"老派牛皮沙发", bom:{2102:4, 1501:2}},
{level:3,id:3209,name:"单人田园床", bom:{2102:4, 1501:2}},
{level:3,id:3210,name:"古典长木桌", bom:{2102:4, 1501:2}},
{level:3,id:3211,name:"红白间条太阳伞", bom:{2102:4, 1501:2}},

{level:3,id:3301,name:"粗制弹药箱", bom:{2203:2, 2101:8}},
{level:3,id:3302,name:"砍刀", bom:{1101:500, 1201:150, 1301:15, 1202:4}},
{level:3,id:3303,name:"蒙德拉贡步枪", bom:{1101:1200, 2201:6, 1401:6}},
{level:3,id:3304,name:"雷明顿M870", bom:{2201:17, 2204:9}},
{level:3,id:3305,name:"UZI冲锋枪", bom:{2202:10, 2204:10, 1404:20}},
{level:3,id:3306,name:"专家型复合弓", bom:{2202:10, 2205:10, 1405:10, 1503:8}},

{level:3,id:3401,name:"休闲卫衣", bom:{1402:5, 2301:5}},
{level:3,id:3402,name:"警用卫衣", bom:{2302:10, 2303:10, 2205:10}},
{level:3,id:3403,name:"探险专家", bom:{2302:9, 2303:9, 1402:10}},







{level:9,id:9001,name:"无级"}
];



var map = {};

var halfSelect = $("#halfSelect");
var itemSelect = $("#itemSelect");

for(i in items){
	var item = items[i];
	// console.log(item.name);
	map[item.id] = item;
	if(item.level == 2){
		halfSelect.append("<option value='" + item.id + "'>"+ item.name +"</option>");
	}
	if(item.level == 3){
		// console.log(item.name);
		itemSelect.append("<option value='" + item.id + "'>"+ item.name +"</option>");
	}
}

// 递归取最底层的组成元素
function getBomItems(rootId){
	var root = map[rootId];
	var boms = {};
	var bom = root.bom;
	var itemId = -1;
	for(itemId in bom){
		var item = map[itemId];
		// console.log(item);

		if(item.level == 1){
			if(boms[itemId] == null){
				boms[itemId] = bom[itemId];
				// console.log(boms[itemId]);
			}else{
				boms[itemId] = boms[itemId] + bom[itemId];
				// console.log(boms[itemId]);
			}
		}else{
			var childBoms = getBomItems(itemId);
			var childId = -1;
			for(childId in childBoms){

				if(boms[childId] == null){
					boms[childId] = childBoms[childId] * bom[itemId];
				}else{
					boms[childId] = boms[childId] + childBoms[childId] * bom[itemId];
					// console.log("22 -- " + boms[childId]);
				}
			}
		}
	}
	// console.log(boms);
	return boms;
}

function showItems(rootId){
	var boms = getBomItems(rootId);
	var result = "";
	var itemId = -1;
	for(itemId in boms){
		var str = map[itemId].name + " -- " + boms[itemId];
		result += str + "\n";
		console.log(str);
	}

	// 加上第一层的
	var root = map[rootId];
	result += "\n\n";
	for(itemId in root.bom){
		var item = map[itemId];
		result += item.name + "  --  " + root.bom[itemId] + "\n";
	}
	$("#result").val(result);
}

showItems(3101);

$("#itemSelect, #halfSelect").change(function(){
	var rootId =$(this).children('option:selected').val();
	showItems(rootId);
});





