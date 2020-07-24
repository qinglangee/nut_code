using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using Newtonsoft.Json;

namespace xmalloc.Util {

    public class DataUtil {
        public static T ReadData<T>(string filePath) {
            string content = FileUtil.ReadFile(filePath);
            if(content == null) {
                return default(T);
            }
            
            T obj = JsonConvert.DeserializeObject<T>(content);
            return obj;
        }

        public static void WriteData(object obj, string filePath) {
            string content = JsonConvert.SerializeObject(obj);
            FileUtil.WriteFile(filePath, content);
        }
    }
}
