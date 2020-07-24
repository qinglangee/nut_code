using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace xmalloc.chuang {

    public class Spawner01 : MonoBehaviour {
        public float spawnDelta = 120;  // 生新怪的时间间隔
        public GameObject child;

        GameObject monsterPre;

        float lastSpawnTime = 0;
	    void Start () {
            monsterPre = Resources.Load<GameObject>("Prefabs/Enemy/Zolrik");
	    }
	
	    // Update is called once per frame
	    void Update () {
            checkSpawn();
	    }

        void checkSpawn() {
            if(Time.time - lastSpawnTime < spawnDelta) {
                return;
            }
            lastSpawnTime = Time.time;

            if(child != null && child.activeSelf) {
                return;
            }
            child = createMonster();

        }

        GameObject createMonster() {
            GameObject newObj = Instantiate(monsterPre, transform.position, Quaternion.identity);
            newObj.transform.parent = transform;
            return newObj;
        }
    }
}
