using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

using Hellmade.Sound;

using xmalloc.Util;
namespace xmalloc.chuang {

    public class BagPanel : MonoBehaviour {
        public Button close;

        public GameObject mainPanel;
        public GameObject bagPanel;

        Dictionary<string, Item> bag;
        ObjAudio objAudio;
        // Use this for initialization
        void Start() {
            objAudio = new ObjAudio();
            BindEvent();

            //testBag();

            bag = GameObject.Find("Player").GetComponent<Player>().GetBag();
            InitBag();
        }

        // 按钮事件绑定
        public void BindEvent() {
            close.onClick.AddListener(delegate () { CloseBagPanel(); });
        }

        // 关闭背包，打开主界面
        public void CloseBagPanel() {
            objAudio.PlaySound("Land");
            bagPanel.SetActive(false);
            mainPanel.SetActive(true);
        }


        public void InitBag() {
            if(bag == null || bag.Count == 0) {
                return;
            }
            GridLayoutGroup gridArea = transform.GetComponentInChildren<GridLayoutGroup>();
            // 先把以前的都清空
            for(int j = gridArea.transform.childCount; j>0;j--) {
                Transform item = gridArea.transform.GetChild(j - 1);
                if(item.childCount > 0) {
                    if(item != null) {
                        Destroy(item.GetChild(0).gameObject);
                    }
                }
            }

            GameObject bagItemPre = Resources.Load<GameObject>("Prefabs/UI/BagItem");
            int i = 0;
            foreach(Item item in bag.Values) {
                GameObject newItem = Instantiate(bagItemPre);
                newItem.GetComponentInChildren<Image>().sprite = Resources.Load<Sprite>(item.IconPath);
                newItem.GetComponentInChildren<Text>().text = "" + item.Count;
                print("count ;" + gridArea.transform.childCount);
                newItem.transform.SetParent(gridArea.transform.GetChild(i), false);

                i++;
            }
        }
    }
}
