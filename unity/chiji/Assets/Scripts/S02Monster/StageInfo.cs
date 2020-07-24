using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace Stage02
{
    public class StageInfo
    {
        public bool point01 = false; // 进门
        public bool point02 = false; // 终点
        public bool point03 = false; // 血瓶

        private static StageInfo instance;
        private StageInfo()
        {

        }

        public static StageInfo GetInstance()
        {
            if(instance == null)
            {
                instance = new StageInfo();
            }
            return instance;
        }

    }

}
