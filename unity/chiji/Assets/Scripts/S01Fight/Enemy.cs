using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

public class Enemy : MonoBehaviour {

	public EnemySpawn spawner;

	bool dead = false;
	float deadTime = 0f;
	float health = 100f;
	public float maxHealth = 100f;

	Material material;
	Transform navTarget;
	NavMeshAgent navAgent;

	BloodBar bloodBar;
	// Use this for initialization
	void Start () {
        
		material = GetComponent<MeshRenderer>().material;
		navAgent = GetComponent<NavMeshAgent>();        
		navTarget = GameObject.FindWithTag("Player").transform;
		bloodBar = transform.Find("BloodBar").GetComponent<BloodBar>();
		print("bar  " + (bloodBar == null));


	}
	
	// Update is called once per frame
	void FixedUpdate () {
		if(!dead){
			navAgent.SetDestination(navTarget.position);
		}else{
			material.color = Color.red;
			deadTime += Time.deltaTime;
			navAgent.SetDestination(transform.position);
		}
		// print("fix time " + Time.fixedTime);
		if(deadTime > 0.5){
			Destroy(gameObject);

		}
	}



	public void Dead(){
		dead = true;
		spawner.EnemyDead();
	}

	public void Hurt(float count){
		if(dead){
			return;
		}
		health -= count;
		bloodBar.Persent = health / maxHealth;
		if(health <= 0){
			Dead();
		}
	}
}
