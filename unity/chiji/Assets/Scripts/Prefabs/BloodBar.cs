using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BloodBar : MonoBehaviour {

	private float persent;
	Transform green;
	// Use this for initialization
	void Start () {
		green = transform.Find("Green");
		persent = 1f;
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	public float Persent{
		get{return persent;}
		set{
			print("set per " + value);
			persent = value < 0 ? 0 : value;
			persent = persent > 1 ? 1 : persent;
			Vector3 scale = green.localScale;
			green.localScale = new Vector3(persent, scale.y, scale.z);
		}
	}
}
