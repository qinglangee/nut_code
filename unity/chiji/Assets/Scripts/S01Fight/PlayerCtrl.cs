using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerCtrl : MonoBehaviour {
	public GameInput gameInput;
	Transform trans;
	GameObject mainCamera;
	Gun gun;
	float fireDelta = 0f;
	float maxFireDelta = 0.1f;
	float lastFireTime = 0f;


    bool walking = false; //  是否在行走

	void Awake(){
		gameInput = new GameInput();
		
	}

	// Use this for initialization
	void Start () {
		trans = this.transform;
		mainCamera = GameObject.FindWithTag("MainCamera");
		gun = GameObject.FindWithTag("Player").GetComponentInChildren<Gun>();
		print ("start!!!");
	}
	
	// Update is called once per frame
	void Update () {

	}
	void FixedUpdate () {
        // 统一输入的值
        ComputerInput();

        ProcessInput();
        //print("walking:" + walking);
	}

	void ProcessInput(){
		// 调用输入的值
		UpdateMovement();
		// UpdateRotation();

		fireDelta = Time.time - lastFireTime;
		//if(Input.GetButton("Fire2") && fireDelta > maxFireDelta){
		//	lastFireTime = Time.time;
		//	gun.Fire();
		//}
	}

	void ComputerInput(){

		float h = Input.GetAxis("Horizontal");
		float v = Input.GetAxis("Vertical");
		// print("h " + h + " v " + v);


		float x = Input.GetAxisRaw("Mouse X");
		float y = Input.GetAxisRaw("Mouse Y");
		// print("x " + x + "  y " + y);





		if(h != 0 || v != 0){
			gameInput.Movement = new Vector2(h, v);
		}else{
			gameInput.Movement = new Vector2(0, 0);
		}

		if(x != 0 || y != 0){
			gameInput.Rotation = new Vector2(x, y);
		}else{
			gameInput.Rotation = new Vector2(0, 0);
		}
	}

	// 更新位置移动
	void UpdateMovement(){
		Vector2 movement = gameInput.Movement;
		if(movement.x > 0.5 || movement.y > 0.5){
			print("move " + movement);
		}

        if(Mathf.Abs(movement.x) < 0.01 && Mathf.Abs(movement.y) < 0.01)
        {
            if (walking)
            {
                GetComponent<AudioSource>().Stop();
            }
            walking = false;
        }
        else
        {
            if (!walking)
            {
                GetComponent<AudioSource>().Play();
            }
            walking = true;
        }

        trans.Translate(movement.x, 0, movement.y);
		
	}
	// 更新镜头旋转
	void UpdateRotation(){
		Vector2 rotation = gameInput.Rotation;
		if(rotation.x != 0){
			trans.Rotate(0, rotation.x, 0, Space.World);
		}
		if ( rotation.y != 0 ){
			mainCamera.transform.Rotate(-1 * rotation.y, 0, 0);
			gun.transform.Rotate(-1 * rotation.y, 0, 0);
		}
	}
}

