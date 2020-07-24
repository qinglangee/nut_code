using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

namespace Stage02
{
    public class Monster : MonoBehaviour
    {
        public float power = 10;

        // 状态  0 空闲 10 走路  20 跑  30 攻击  90 死亡
        private int state;
        
        Animator anim;
        NavMeshAgent agent;
        // Use this for initialization
        StageInfo info = StageInfo.GetInstance();

        GameObject player;

        Vector3 spawnPoint;
        void Start()
        {
            anim = GetComponent<Animator>();
            agent = GetComponent<NavMeshAgent>();
            player = GameObject.FindWithTag("Player");

            spawnPoint = transform.position;
        }

        // Update is called once per frame
        void FixedUpdate()
        {
            float distance;
            if (info.point01)
            {
                Vector3 playerPos = player.transform.position;
                distance = Vector3.Distance(playerPos, transform.position);
                
                if(distance < 10)
                {
                    State = 20;
                    agent.SetDestination(playerPos);
                    if(distance < 1)
                    {
                        State = 30;
                    }
                }
                else
                {
                    GoBack();
                }
            }
            else
            {
                GoBack();
            }
        }

        private void GoBack()
        {
            float distance = Vector3.Distance(spawnPoint, transform.position);
            agent.SetDestination(spawnPoint);
            if(distance < 0.5)
            {
                State = 0;
            }
            else
            {
                State = 10;
            }
        }

        public int State
        {
            get { return state; }
            set
            {
                state = value;
                anim.SetInteger("state", state);
            }
        }

    }

}
