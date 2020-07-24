using System.Collections;
using System.Collections.Generic;
using System;

using Newtonsoft.Json;
namespace xmalloc.chuang
{

    public class PlayerInfo {
        private float health; // 当前血量
        public float MaxHealth { get; set; } // 最大血量
        public int Level { get; set; } // 人物等级
        public int Step { get; set; } // 主剧情步骤
        [JsonIgnore]
        public bool Attacking { get; set; } // 是否在攻击

        public float Hurt { get; set; } // 伤害力
        public float Defence { get; set; }  // 防御力
        private float exp; // 经验值
        public float MaxExp { get; set; } // 当前等级最大exp

        public Dictionary<string, Item> bag;
        
        public event EventHandler LevelUp;
        public PlayerInfo() {
            health = 100; // 不要用大写的
            MaxHealth = 100;
            Level = 1;
            Step = 0;
            Hurt = 1;
            Defence = 0;
            exp = 0; // 不要用大写的
            MaxExp = LevelInfo.GetLevelExp(Level);

            Attacking = false;

            bag = new Dictionary<string, Item>();
        }

        public float Health {
            get { return health; }
            set {
                health = value;
                if(health > MaxHealth) {
                    health = MaxHealth;
                }
                if(health < 0) {
                    health = 0;
                }
            }
        }
        public float Exp {
            get { return exp; }
            set {
                exp = value;

                if(exp >= MaxExp) {
                    exp = exp - MaxExp;
                    Level += 1;
                    MaxExp = LevelInfo.GetLevelExp(Level);

                    if(LevelUp != null) {
                        LevelUp(this, EventArgs.Empty);
                    }
                }
            }
        }
    }
}
