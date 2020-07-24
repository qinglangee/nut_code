using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;

public class Joystick : MonoBehaviour, IPointerDownHandler, IDragHandler, IPointerUpHandler {
	
	GameInput gameInput;
	// Use this for initialization
	void Start () {
		gameInput = GameObject.FindWithTag("Player").GetComponent<PlayerCtrl>().gameInput;
		// print("p null " + (GameObject.FindWithTag("Player").GetComponent<PlayerCtrl>() == null));
		// print("in null " + (gameInput == null));
	}
	
	public void OnPointerDown(PointerEventData data){

	}

	public void OnDrag(PointerEventData data){
		// print("pos" + data.pressPosition + " curr: " + data.position);
		float v = data.position.y - data.pressPosition.y;
		float h = data.position.x - data.pressPosition.x;
		gameInput.Movement = new Vector2(h, v);
		
	}

	public void OnPointerUp(PointerEventData data){
		// print("pointer up");
		gameInput.Movement = new Vector2(0, 0);
		
	}
}
