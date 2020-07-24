using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

namespace xmalloc.Util {

    public class FileUtil {

        // 读文件
	    public static string ReadFile(string filePath) {
            FileInfo t = new FileInfo(filePath);
            if (!t.Exists) {
                return null;
            }

            StreamReader sr = null;
            sr = File.OpenText(filePath);
            string result = "";
            string line = "";
            while ((line = sr.ReadLine()) != null) {
                result += line;
            }
            sr.Close();
            sr.Dispose();
            return result;
        }

        // 写文件
        public static void WriteFile(string filePath, string content) {
            StreamWriter sw;
            FileInfo t = new FileInfo(filePath);
            
            sw = t.CreateText();
            sw.WriteLine(content);
            sw.Close();
            sw.Dispose();
        }
    }
}
