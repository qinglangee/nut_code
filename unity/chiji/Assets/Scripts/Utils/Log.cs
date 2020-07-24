using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace xmalloc.Util {

    public class Log {

        GameObject gameObject;

        public Log(GameObject gameObject) {
            this.gameObject = gameObject;
        }

        public void i(object msg) {

        }

        public void e(object msg) {

        }

        public void d(object msg) {
            Debug.Log(gameObject.name + ": " + msg);
        }
    }
}
