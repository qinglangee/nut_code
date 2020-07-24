using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using xmalloc.Util;
namespace xmalloc.chuang {

    public class Global {
        private static PlayerInfo playerInfo;
        private static GameObject player;
        

        public static PlayerInfo GetPlayerInfo() {
            if(playerInfo == null) {
                playerInfo = DataUtil.ReadData<PlayerInfo>(Application.persistentDataPath + "/playerinfo.json");
                if(playerInfo == null) {
                    playerInfo = new PlayerInfo();
                }
            }
            return playerInfo;
        }

        public static GameObject GetPlayer() {
            if(player == null) {
                player = GameObject.Find("Player");
            }
            return player;
        }
    }
}
