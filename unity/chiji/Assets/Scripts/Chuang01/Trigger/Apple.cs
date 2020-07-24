using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using xmalloc.Util;
using xmalloc.chuang;
public class Apple : MonoBehaviour {

    Log log;
	// Use this for initialization
	void Start () {
        log = new Log(gameObject);
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    private void OnTriggerEnter(Collider other) {
        //log.d("colider " + other.gameObject.name);
        if(other.gameObject.name == "Player"){

            gameObject.SetActive(false);
            other.gameObject.GetComponent<Player>().PickItem(Items.Get("apple"));
        } else {
            GetComponent<Rigidbody>().isKinematic = true;
        }
    }
}
