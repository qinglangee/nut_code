using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace xmalloc.Prefab {

    public class ValueBar : MonoBehaviour {

        public float persent;

        Transform fill;
        void Start() {
            fill = transform.Find("Fill");
        }

        void Update() {
            Vector3 scale = fill.localScale;
            fill.localScale = new Vector3(persent, scale.y, scale.z);
        }

        public float Value {
            get { return persent; }
            set {
                this.persent = value;
                persent = value < 0 ? 0 : value;
                persent = persent > 1 ? 1 : persent;
            }
        }
    }
}
