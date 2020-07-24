using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Bullet : MonoBehaviour {

	public LayerMask mask = 1;
	public float moveSpeed = 50f;
	public float maxDistance = 100;
	private Vector3 targetPos;
	GameObject hittedPre;
	bool hitted;
	float endTime = 0f;

	bool triggerEnter = false;

	void Awake(){

		hittedPre = (GameObject)Resources.Load("Prefabs/Hitted") as GameObject;
	}

	// Use this for initialization
	void Start () {
		GameObject mainCamera = GameObject.FindWithTag("MainCamera");
		RaycastHit hit;
        hitted = Physics.Raycast(mainCamera.transform.position, this.transform.forward, out hit, maxDistance, mask);  
		if(hitted){
			targetPos = hit.point;
			// print("get target");
		}else{
			targetPos = transform.position + transform.forward * maxDistance;
			// print("target null");
		}

		
		//print("targtet pos " + targetPos);
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	void FixedUpdate(){
		// if(triggerEnter)
		// 	return;

		transform.position = Vector3.MoveTowards(transform.position, targetPos, moveSpeed);
		if((this.transform.position - targetPos).sqrMagnitude < 0.01f){
            // print("接触目标点");
			if(!hitted){
				Destroy(gameObject);
			}else if(endTime > 0.03){
				Destroy(gameObject);
			}
			endTime += Time.deltaTime;

        }
	}
	void OnTriggerEnter(Collider other){
		//print("enter trigger" + other.gameObject.name);
		Instantiate(hittedPre, targetPos, Quaternion.LookRotation(transform.forward));
		// Destroy(this.gameObject);
		Enemy enemy = other.gameObject.GetComponent<Enemy>();
		if(enemy != null){
			//print("hurt enemy: " + other.gameObject.name);

			enemy.Hurt(40);
        }
        else
        {
            HeroBar heroBar = other.gameObject.GetComponent<HeroBar>();
            if(heroBar != null)
            {
                heroBar.Hurt(45);
                heroBar.Hurt(45);
            }
        }
		triggerEnter = true;
	}
	void OnTriggerStay(Collider other){
		//print("triger stay  "  + other.gameObject.name);
	}
	void OnTriggerExit(Collider other){
		//print("triger exit  "  + other.gameObject.name);
	}
}
