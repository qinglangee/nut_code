using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;

using xmalloc.Util;
using xmalloc.Prefab;
namespace xmalloc.chuang {

    public class BeatTarget : MonoBehaviour {

        public float health = 10; // 生命值
        public float maxHealth = 10; // 最大生命值
        public float exp = 1; // 打一下的经验值


        public float raiseHealthDelta = 3f;
        public float raiseHealthSpeed = 3f;

        public AudioClip hurtAudio; // 受伤声音
        public AudioClip dieAudio;  // 死亡声音



        private float lastRaiseTime = 0; // 上次回复的时间


        GameObject bloodBar;

        public event EventHandler Die;

        ObjAudio objAudio = new ObjAudio();
        // Use this for initialization
        void Start () {
	    }
	
	    // Update is called once per frame
	    void Update () {

            // 显示血量
            showHealth();
        }



        // 回复血量, 在主体中调用的
        public void RaiseHealth() {
            if (Time.time - lastRaiseTime < raiseHealthDelta) {
                return;
            }
            lastRaiseTime = Time.time;

            EditHealth(raiseHealthSpeed);

        }


        // 显示血量
        void showHealth() {
            if (health >= maxHealth || health <= 0) {
                return;
            }
            print("show health " + health + " max " + maxHealth );
            if (bloodBar == null) {
                GameObject prefab = Resources.Load("Prefabs/UI/ValueBar") as GameObject;
                bloodBar = Instantiate(prefab);
                GameObject canvas = GameObject.Find("Canvas");
                bloodBar.transform.SetParent(canvas.transform, false);
            }

            Vector3 pos = Camera.main.WorldToScreenPoint(transform.position + new Vector3(0, 1.6f, 0));
            bloodBar.transform.position = pos;
            //log.d("blood position " + bloodBar.transform.position);
        }


        // 被打
        public void Hurt(float hurt) {

            if (health <= 0) {
                return;
            }


            EditHealth(-hurt);

            objAudio.PlaySound("hurtAudio", hurtAudio);
            // 伤害数值动画
            RiseText.createRiseText(transform, "-" + hurt);
            //print("target hurt");
            if (Health <= 0) {
                DieEvent();
            }

        }

        // 修改生命值
        private void EditHealth(float count) {
            Health += count;
            if (bloodBar != null) {
                if(Health < maxHealth && Health > 0) {
                    bloodBar.GetComponent<ValueBar>().Value = health / maxHealth;
                    bloodBar.SetActive(true);
                } else {
                    bloodBar.SetActive(false);
                }
            }
        }


        private void DieEvent() {
            objAudio.PlaySound("dieAudio", dieAudio);

            // TODO  EVENT
            //GetComponent<PunchMonster>().State = 90;
            if(Die != null) {
                Die(this, EventArgs.Empty);
            }
        }


        ////////////////////////////////////////////////////////////////////
        ///  get set
        public float Exp {
            get { return exp; }
        }

        public float Health {
            get { return health; }
            set {
                health = value;
                if(health > maxHealth) {
                    health = maxHealth;
                }
            }
        }

    }
}
