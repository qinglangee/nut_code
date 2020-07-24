using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace xmalloc.chuang {

    public class Attacker : MonoBehaviour {

        public float Hurt { get; set; }

        public Item Item { get; set; }

        PlayerInfo playerInfo;
        Player player;
	    // Use this for initialization
	    void Start () {
            playerInfo = Global.GetPlayerInfo();
            player = GetComponent<Player>();
            if (Item != null) {
                Hurt = Item.TypeValue;
            } else {
                Hurt = playerInfo.Hurt;
            }
	    }
	
	    // Update is called once per frame
	    void Update () {
		
	    }

        // 碰撞检测
        private void OnTriggerEnter(Collider other) {
            if (!playerInfo.Attacking) {
                return;
            }
            //print("attacker  attack");
            BeatTarget target = other.GetComponent<BeatTarget>();
            if (target != null) {

                target.Hurt(Hurt);
                player.EditExp(target.Exp);
            }
        }
    }
}
