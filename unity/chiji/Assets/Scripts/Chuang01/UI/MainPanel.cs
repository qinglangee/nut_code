using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

using xmalloc.Util;
namespace xmalloc.chuang {

    public class MainPanel : MonoBehaviour {
        public Button userInfo;
        public Button bagBtn;
        public Button settingBtn;

        public GameObject mainPanel;
        public GameObject playerPanel;
        public GameObject bagPanel;
        public GameObject dialogPanel;
        public GameObject settingPanel;

        ObjAudio objAudio;
        // Use this for initialization
        void Start() {
            objAudio = new ObjAudio();
            bindEvent();
        }

        // Update is called once per frame
        void Update() {

        }

        private void bindEvent() {
            userInfo.onClick.AddListener(delegate () { OpenPlayerPanel(); });
            bagBtn.onClick.AddListener(delegate () { OpenBagPanel(); });
            settingBtn.onClick.AddListener(delegate () { OpenSettingPanel(); });
        }


        // 打开玩家信息界面
        public void OpenPlayerPanel() {
            objAudio.PlaySound("Land");
            playerPanel.SetActive(true);
            mainPanel.SetActive(false);
            playerPanel.GetComponent<PlayerPanel>().InitPanel();
        }
        // 打开背包
        public void OpenBagPanel() {
            objAudio.PlaySound("Land");

            bagPanel.SetActive(true);
            mainPanel.SetActive(false);

            bagPanel.GetComponent<BagPanel>().InitBag();
        }
        // 打开设置界面
        public void OpenSettingPanel() {
            objAudio.PlaySound("Land");
            settingPanel.SetActive(true);
            mainPanel.SetActive(false);

        }
    }

}