using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace xmalloc.chuang {

    public class LevelInfo {
        
        public static float GetLevelExp(int level) {
            float exp = 10;
            for (int i = 0; i < level; i++) {
                exp *= 1.5f;
            }
            exp = Mathf.Floor(exp);
            return exp;
        }
	  
    }
}
