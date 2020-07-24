using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using xmalloc.Prefab;
namespace xmalloc.chuang {

    public class HealthRecover : MonoBehaviour {

        public bool recovering = false;

        public float lastTime = 0;
        public float recoverDelta = 1;
        public float riseCount = 5;

        Player player;
	    // Use this for initialization
	    void Start () {
		
	    }
	
	    // Update is called once per frame
	    void FixedUpdate () {
		    if(Time.time - lastTime < recoverDelta || !recovering) {
                return;
            }
            lastTime = Time.time;

            RiseText.createRiseText(transform, "+" + riseCount);

            player.EditHealth(riseCount);

	    }

        private void OnTriggerEnter(Collider other) {
            if(other.gameObject.name == "Player") {
                player = other.gameObject.GetComponent<Player>();
                recovering = true;
            }
        }

        private void OnTriggerExit(Collider other) {
            if(other.gameObject.name == "Player") {
                recovering = false;
            }
        }
    }
}
