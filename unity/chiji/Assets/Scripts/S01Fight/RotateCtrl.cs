using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class RotateCtrl : MonoBehaviour, IDragHandler, IPointerDownHandler {
	GameObject mainCamera;
	GameObject player;
	GameObject gun;
	Vector2 lastPos;


	public float rotateSpeed = 1f;
	// Use this for initialization
	void Start () {
		player = GameObject.FindWithTag("Player");
		mainCamera = GameObject.FindWithTag("MainCamera");
		gun = GameObject.FindWithTag("Gun");
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	public void OnDrag(PointerEventData data){
		float x = (data.position.x - lastPos.x) * rotateSpeed;
		float y = (data.position.y - lastPos.y) * rotateSpeed;
		
		Vector2 rotation = new Vector2(x, y);



		if(rotation.x != 0){
			player.transform.Rotate(0, rotation.x, 0, Space.World);
		}
		if ( rotation.y != 0 ){
			mainCamera.transform.Rotate(-1 * rotation.y, 0, 0);
			gun.transform.Rotate(-1 * rotation.y, 0, 0);
		}

		lastPos = data.position;
	}

	public void OnPointerDown(PointerEventData data){
		lastPos = data.pressPosition;
	}
}
