using System.Collections;
using System.Collections.Generic;
using UnityEngine;


namespace xmalloc.chuang {

    public class Items {
        static Dictionary<string, Item> map;
        public static Item Get(string name) {
            return Get(name, 1);
        }
        public static Item Get(string name, int count) {
            Item temp = null;
            Item item = null;
            if(map == null) {
                InitMap();
            }
            map.TryGetValue(name, out temp);
            if(temp != null) {
                item = temp.Clone();
                item.Count = count;
            }
            return item;
        }


        // 添加一个item
        private static void AddToMap(string code, string name, string iconPath, int exp, int type, int value) {
            Item item = new Item(code, name, iconPath, exp, type, value);
            map.Add(code, item);
        }
        private static void InitMap() {
            map = new Dictionary<string, Item>();
            AddToMap("apple", "苹果", "Images/apple", 111, 1, 20);
        }
	   
    }
}
