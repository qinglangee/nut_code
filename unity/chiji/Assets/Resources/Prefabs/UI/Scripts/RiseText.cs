using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

using xmalloc.Util;
namespace xmalloc.Prefab {

    public class RiseText : MonoBehaviour {
        Log log;
        static GameObject riseText;
        static GameObject staticCanvas;
        
        Text obj;
	    // Use this for initialization
	    void Awake () {
            obj = GetComponent<Text>();
            obj.resizeTextForBestFit = true;
            log = new Log(gameObject);
	    }
	
	    public void Init(string text) {
            obj.text = text;
        }
        public void Init(string text, Color color) {
            obj.text = text;
            obj.color = color;
            //print("resize " + obj.resizeTextForBestFit);
        }

        public void DestroyText() {
            Destroy(gameObject);
        }


        // 创建伤害显示
        public static void createRiseText(Transform tf, string content) {
            
            createRiseText(tf, content, Color.red, staticCanvas);
        }
        public static void createRiseText(Transform tf, string content, Color color) {
            createRiseText(tf, content, color, staticCanvas);
        }
        // 创建伤害显示
        public static void createRiseText(Transform tf, string content, Color color, GameObject canvas) {
            if (canvas == null) {
                canvas = GameObject.Find("Canvas");
                staticCanvas = canvas;
            }

            if (riseText == null) {
                riseText = Resources.Load("Prefabs/UI/RiseText") as GameObject;
            }
            Vector3 pos = tf.position; // + new Vector3(0, 2, 0);
            Vector3 point = Camera.main.WorldToScreenPoint(pos);
            //print("text position :" + point);
            GameObject newText = Instantiate(riseText, point, Quaternion.identity);


            newText.GetComponent<RiseText>().Init(content, color);
            newText.transform.SetParent(canvas.transform, false);
        }
    }
}
