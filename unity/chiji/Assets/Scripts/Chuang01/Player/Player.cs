using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

using xmalloc.Prefab;
using xmalloc.Util;

using Newtonsoft.Json;
namespace xmalloc.chuang
{
    public class Player : MonoBehaviour {
        public float hurt;
        public float defence;

        public ValueBar healthBar;
        public GameObject deadPanel;

        Log log;
        PlayerInfo info;
        Animator anim;

        Dictionary<string, Item> bag;
        ObjAudio objAudio;
        private void Awake()
        {
            log = new Log(gameObject);
            info = Global.GetPlayerInfo();
            bag = info.bag;
            objAudio = new ObjAudio();

            info.LevelUp += LevelUp;
        }
        // Use this for initialization
        void Start()
        {
            testData();


            anim = GetComponent<Animator>();

            if(info.Health <= 0) {
                info.Health = Mathf.Floor(info.MaxHealth * 0.2f);
            }
            EditHealth(0);

        }

        void testData() {
            info.Hurt = hurt;
            info.Defence = defence;
        }


        // Update is called once per frame
        void FixedUpdate()
        {

            if (Input.GetButtonDown("Fire1"))
            {
                StartAttack();
            }
            if (Input.GetButtonDown("Fire2"))
            {
                //anim.SetBool("Attack", false);
            }

            CheckLocation();
        }

        // 检查位置，掉下去就死亡
        private void CheckLocation() {
            if(transform.position.y < 180) {
                EditHealth(-9999);
            }
        }

        public void StartAttack() {
            info.Attacking = true;
            anim.SetBool("Attack", true);

        }
        public void EndAttack() {

            info.Attacking = false;
            anim.SetBool("Attack", false);
        }

        public void Hurt(float power) {
            //print("health " + info.Health);

            float hurt = power - info.Defence;
            if(hurt > 0) {
                EditHealth(-hurt);
            }
        }

        // 捡到物品
        public void PickItem(Item item) {
            objAudio.PlaySound("GetItem");
            RiseText.createRiseText(transform, item.Name + " +" + item.Count, Color.green);

            EditExp(item.Exp);

            Item temp;
            bag.TryGetValue(item.Name, out temp);
            if(temp == null) {
                bag.Add(item.Name, item);
            } else {
                temp.Count += item.Count;
                bag.Remove(item.Name);
                bag.Add(item.Name, temp);
            }

            WritePlayerInfo();

        }
        // 获取背包内容
        public Dictionary<string, Item> GetBag() {
            return bag;
        }
        // 死亡
        public void Dead() {
            anim.SetBool("Dead", true);
            gameObject.SetActive(false);
            deadPanel.SetActive(true);
        }
        // 复活回出生点
        public void ReLive() {
            
        }

        // 升级
        public void LevelUp(object obj, EventArgs args) {
            objAudio.PlaySound("LevelUp");
            StartCoroutine(Timer("abcd"));
        }

        IEnumerator Timer(string name) {
            yield return new WaitForSeconds(3.0f);
            Debug.Log(string.Format("Timer2 is up !!! time=${0}", name));
        }

        // 写入玩家信息
        private void WritePlayerInfo() {
            // TODO 不用线程会不会卡顿呢
            DataUtil.WriteData(info, Application.persistentDataPath + "/playerinfo.json");
        }

        // 修改生命值
        public void EditHealth(float count) {
            info.Health += count;
            healthBar.Value = info.Health / info.MaxHealth;

            if (info.Health <= 0) {
                Dead();
            }
        }
        // 修改经验
        public void EditExp(float count) {
            info.Exp += count;
            // 升级特效什么的


            WritePlayerInfo();
        }


    }
}

