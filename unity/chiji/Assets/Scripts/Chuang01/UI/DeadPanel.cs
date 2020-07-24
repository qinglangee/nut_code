using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

namespace xmalloc.chuang {

    public class DeadPanel : MonoBehaviour {
        public Button btn;
	    // Use this for initialization
	    void Start () {
            bindEvent();
	    }
	
	    public void bindEvent() {
            btn.onClick.AddListener(delegate() {
                gameObject.SetActive(false);
                SceneManager.LoadScene(SceneManager.GetActiveScene().name);
            });
        }
    }
}
