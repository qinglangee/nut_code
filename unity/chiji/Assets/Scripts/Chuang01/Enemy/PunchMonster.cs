using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
using System;

using xmalloc.Util;
namespace xmalloc.chuang {
    
    public class PunchMonster : MonoBehaviour {
        public float hurt = 30; // 攻击力量
        public float defence = 0; // 防御值


        public float watchDis = 10;  // 警戒距离
        public float attackDis = 2f;  // 攻击距离
        public float kissDis = 1f;  // 最近距离
        public float walkSpeed = 1.5f; 
        public float runSpeed = 2.5f;

        public float showDis; // 测试用


        public AudioClip attackAudio;


        // 状态  0 空闲 10 走路  20 跑  30 攻击  90 死亡 100 退出状态控制
        private int state;

        Animator anim;
        NavMeshAgent agent;

        GameObject player;

        Vector3 spawnPoint;
        Log log;
        ObjAudio objAudio = new ObjAudio();
        PlayerInfo playerInfo;
        BeatTarget life;

        float deadTime = 0;
        void Start() {
            log = new Log(gameObject);
            anim = GetComponent<Animator>();
            agent = GetComponent<NavMeshAgent>();
            player = GameObject.FindWithTag("Player");

            spawnPoint = transform.position;
            playerInfo = Global.GetPlayerInfo();
            life = GetComponent<BeatTarget>();
            life.Die += OnDie;
        }

        // Update is called once per frame
        void FixedUpdate() {

            FindPlayer();

            //showHealth();

            if (State < 20) {
                life.RaiseHealth();
            }

            //log.d("state:" + State);
            if (State == 100 && Time.time - deadTime > 3) {
                Destroy(gameObject);
            }
        }

        private void FindPlayer() {
            if (life.health <= 0) {
                return;
            }
            float distance;

            Vector3 playerPos = player.transform.position;
            distance = Vector3.Distance(playerPos, transform.position);
            showDis = distance;
            if (distance < watchDis) {
                State = 20;
                agent.speed = runSpeed;
                if (distance > kissDis) {
                    agent.SetDestination(playerPos);
                } else {
                    agent.SetDestination(transform.position);
                }
                if (distance < attackDis) {
                    State = 30;
                }
            } else {
                GoBack();
            }
        }

        private void Update() {
        }
        // 回巡逻位置
        private void GoBack() {
            float distance = Vector3.Distance(spawnPoint, transform.position);
            agent.SetDestination(spawnPoint);
            if (distance < 0.5) {
                State = 0;
            } else {
                State = 10;
                agent.speed = walkSpeed;
            }
        }



        public int State {
            get { return state; }
            set {
                state = value;
                anim.SetInteger("state", state);
            }
        }


        public void AttackSound() {
            objAudio.PlaySound("attackAudio", attackAudio);
        }
        public void AttackEnd() {
            float distance = Vector3.Distance(transform.position, player.transform.position);
            //print("mons dis " + distance + " ata " + attackDis + " hurt " + hurt);
            if(distance < attackDis) {
                player.GetComponent<Player>().Hurt(hurt);
            }
        }



        public void QuitAnim() {
            deadTime = Time.time;
            State = 100;
        }

        public void OnDie(object obj, EventArgs args) {
            State = 90;
        }


    }

}

