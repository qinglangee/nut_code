using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class HittedTrace : MonoBehaviour {
	public float maxTime = 1;
	private float liveTime = 0;
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		liveTime += Time.deltaTime;
		if(liveTime > maxTime){
			Destroy(gameObject);
		}
	}
}
