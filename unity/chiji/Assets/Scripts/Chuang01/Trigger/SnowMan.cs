using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using Hellmade.Sound;

using xmalloc.Util;
namespace xmalloc.chuang {
    public class SnowMan : MonoBehaviour {
        Log log;

        public AudioControl[] audioControls;

        private PlayerInfo info;


        public DialogPanel dialogPanel;

        // Use this for initialization
        void Start() {
            info = Global.GetPlayerInfo();

            log = new Log(gameObject); 

        }

        // Update is called once per frame
        void Update() {

        }

        void OnTriggerEnter(Collider other) {
            log.d("snow collider " + other.gameObject.name);
            dialogPanel.showStep();
        }
        void OnTriggerExit(Collider other) {
            dialogPanel.ClosePanel();
        }
    }
    [System.Serializable]
    public class AudioControl {
        public AudioClip audioclip;
        public Audio audio;
    }
}
