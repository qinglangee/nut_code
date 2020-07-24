using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace xmalloc.chuang {

    public class Item {
        public string Code { get; set; } // 引用名
        public string Name { get; set; } // 显示名
        public string IconPath { get; set; } // 图标
        public Sprite Icon { get; set; }
	    public int Count { get; set; } // 叠加数量
        public int Exp { get; set; } // 经验值
        public int Type { get; set; } // 物品类型  1 食物  2 武器 3 防具
        public float TypeValue { get; set; } // 物品功能价值

        public Item() { }
        
        public Item(string code, string name,string iconPath, int exp, int type, int typeValue) {
            Init(code, name, iconPath, exp, type, typeValue);
        }

        public void Init(string code, string name, string iconPath, int exp, int type, int typeValue) {
            Code = code;
            Name = name;
            IconPath = iconPath;
            Count = 1;
            Exp = exp;
            Type = type;
            TypeValue = typeValue;
        }

        public Item Clone() {
            return this.MemberwiseClone() as Item;
        }
    }
}

