using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

using xmalloc.Util;
namespace xmalloc.chuang {

    public class SettingPanel : MonoBehaviour {
        public Button close;

        public GameObject mainPanel;
        public GameObject selfPanel;
        ObjAudio objAudio;
        // Use this for initialization
        void Start () {
            objAudio = new ObjAudio();
            BindEvent();
        }

        // 按钮事件绑定
        public void BindEvent() {
            close.onClick.AddListener(delegate () { ClosePanel(); });
        }

        // 关闭背包，打开主界面
        public void ClosePanel() {
            selfPanel.SetActive(false);
            mainPanel.SetActive(true);
            objAudio.PlaySound("Land");
        }
    }
}
