using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using Hellmade.Sound;
using xmalloc.Util;
using xmalloc.Prefab;

namespace xmalloc.chuang {


    public class AppleSpawner : MonoBehaviour {

        public GameObject[] apples;
        


        float health = 5;
        public float maxHealth = 5;
        public float spawnRate = 30f;
        public float spawnTime = 60;

        float lastTime = 0;

        Log log;
        PlayerInfo info; // 玩家信息
        Vector3[] originPos; // 原果子位置

        GameObject riseText;
        GameObject canvas;
        ObjAudio objAudio;
        // Use this for initialization
        void Start() {
            log = new Log(gameObject);
            info = Global.GetPlayerInfo();
            originPos = new Vector3[apples.Length];
            for(int i = 0; i < apples.Length; i++) {
                originPos[i] = apples[i].transform.position;
            }
            canvas = GameObject.Find("Canvas");
            objAudio = new ObjAudio();
        }

        // Update is called once per frame
        void FixedUpdate() {
            recoverApple();
        }
        // 再生苹果
        private void recoverApple() {
            if(Time.time - lastTime < spawnTime) {
                return;
            }
            lastTime = Time.time;



            float value = Random.Range(0, 100);
            //log.d("random value:" + value);
            if (value < spawnRate) {
                for(int i = 0;i < apples.Length;i++) {
                    GameObject apple = apples[i];
                    //log.d("active:" + apple.activeSelf + " hi  " + apple.activeInHierarchy);
                    if (!apple.activeSelf) {

                        apple.transform.position = originPos[i];
                        Rigidbody rigid = apple.GetComponent<Rigidbody>();
                        rigid.useGravity = false;
                        rigid.isKinematic = false;
                        apple.SetActive(true);
                        break;
                    }
                }
            }
        }

        // 被打了
        private void OnTriggerEnter(Collider other) {
            //log.d("name:" + other.name + "  attack:" + info.attacking + " health " + health);
            if (info.Attacking) {
                health -= info.Hurt;
                // 伤害数值动画
                RiseText.createRiseText(transform, "-" + info.Hurt);

                if(health <= 0) {
                    Boom();
                }

                objAudio.PlaySound("HitWood");
            }
        }

        // 被打爆了
        void Boom() {
            for(int i=0;i<apples.Length;i++) {
                GameObject apple = apples[i];
                if (apple.activeSelf && apple.transform.position == originPos[i]) {
                    apple.GetComponent<Rigidbody>().useGravity = true;
                    break;
                }
            }
            health = maxHealth;
        }

       
    }
}
