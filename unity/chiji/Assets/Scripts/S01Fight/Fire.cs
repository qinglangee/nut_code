using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;


public class Fire : MonoBehaviour, IPointerDownHandler,IPointerUpHandler {

	private bool firing = false;
	private AudioSource fireAudio;
	private float lastFireTime;
	public float maxFireDelta = 0.8f;
	// Use this for initialization
	Gun gun;
	void Start () {
		fireAudio = GetComponent<AudioSource>();
		gun = GameObject.FindWithTag("Player").GetComponentInChildren<Gun>();
	}
	
	// Update is called once per frame
	void Update () {
		
	}

	void FixedUpdate(){
		float fireDelta = Time.time - lastFireTime;
		if(firing && fireDelta > maxFireDelta){
			lastFireTime = Time.time;
            fireAudio.Play();

            gun.Fire();
		}
	}

	public void OnPointerDown(PointerEventData data){
		firing = true;

    }

	public void OnPointerUp(PointerEventData data){
		firing = false;
	}
}
