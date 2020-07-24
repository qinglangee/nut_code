using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EnemySpawn : MonoBehaviour {

    public TakePhoto tp;

	GameObject enemyPre;
	public int maxEnemyCount = 10; // 能生产的最大数量
	private int spawnCount = 0;   // 出生的数量
	public int liveCount = 0; // 活着的数量

	System.Random random = new System.Random();




	// Use this for initialization
	void Start () {
		enemyPre = Resources.Load("Prefabs/Enemy") as GameObject;

		for(int i=0;i<3;i++){
			SpawnEnemy();
		}


    }

    // Update is called once per frame
    void FixedUpdate () {
		
	}

	private void SpawnEnemy(){
		liveCount++;
		spawnCount++;

		float x = random.Next(1, 34) - 17f;
		float z = random.Next(1, 20) + 20f;
		Vector3 position = new Vector3(x, 1.25f, z);
		GameObject enemy = Instantiate(enemyPre, position, Quaternion.LookRotation(Vector3.forward));
		enemy.GetComponent<Enemy>().spawner = this;

	}

	public void EnemyDead(){
		liveCount--;
		if(spawnCount < maxEnemyCount){
			SpawnEnemy();
		}

        TakePhoto();
	}

    private void TakePhoto()
    {
        if (tp.StartCam())
        {
            tp.SavePhoto();
        }
    }
}
