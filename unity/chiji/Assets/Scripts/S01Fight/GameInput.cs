using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameInput {
	public float moveSpeed = 0.1F;
	public float rotateSpeed = 5;

	private Vector2 rotation;
	private Vector2 movement;

	public GameInput(){
		rotation = new Vector2();
		movement = new Vector2();
	}

	public Vector2 Rotation{
		get{return rotation;}
		set{
			float x = value.x;
			x = x > 1 ? 1 : (x < -1 ? -1 : x);
			float y = value.y;
			y = y > 1 ? 1 : (y < -1 ? -1 : y);
			rotation.x = x * rotateSpeed;
			rotation.y = y * rotateSpeed;
		}
	}

	public Vector2 Movement{
		get{return movement;}
		set{
			
			float x = value.x;
			float y = value.y;
			float absX = Mathf.Abs(x);
			float absY = Mathf.Abs(y);
			if(absX > 1 || absY > 1){
				if(absX > absY){
					x = x / absX;
					y = y / absX;
				}else{
					y = y / absY;
					x = x / absY;

				}
			}

				
			// x = x > 1 ? 1 : (x < -1 ? -1 : x);
			// y = y > 1 ? 1 : (y < -1 ? -1 : y);
			movement.x = x * moveSpeed;
			movement.y = y * moveSpeed;
		}
	}

}

