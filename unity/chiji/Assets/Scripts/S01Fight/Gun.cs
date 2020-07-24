using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Gun : MonoBehaviour {

	GameObject bulletPre;
	Transform firePointTF;
	// Use this for initialization
	void Start () {
		bulletPre = (GameObject)Resources.Load("Prefabs/Bullet") as GameObject;
		firePointTF = transform.Find("FireTF");
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	public void Fire(){
		print("fire pos " + firePointTF.position);
		Instantiate(bulletPre, firePointTF.position, Quaternion.LookRotation(firePointTF.forward));
		// test();
	}

	private void test(){
		Vector3 p = firePointTF.position;
		Instantiate(bulletPre, new Vector3(p.x,1.5f,p.z), Quaternion.LookRotation(firePointTF.forward));
		Instantiate(bulletPre, new Vector3(p.x,1f,1.2f), Quaternion.LookRotation(firePointTF.forward));
		Instantiate(bulletPre, new Vector3(1,2f,3f), Quaternion.LookRotation(firePointTF.forward));
		Instantiate(bulletPre, new Vector3(p.x,1f,3f), Quaternion.LookRotation(firePointTF.forward));
		Instantiate(bulletPre, new Vector3(p.x,1f,2f), Quaternion.LookRotation(firePointTF.forward));
		Instantiate(bulletPre, new Vector3(p.x,1f,1f), Quaternion.LookRotation(firePointTF.forward));
	}
}
