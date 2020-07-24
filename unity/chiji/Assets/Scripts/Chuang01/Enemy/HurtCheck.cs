using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace xmalloc.chuang {

    public class HurtCheck : MonoBehaviour {
        public float hurt;

	    // Use this for initialization
	    void Start () {
		
	    }
	
	    // Update is called once per frame
	    void Update () {
		
	    }

        private void OnTriggerEnter(Collider other) {
            if(other.gameObject.name == "Player") {
                Player player = other.GetComponent<Player>();
                player.Hurt(hurt);
            }
        }
    }
}
