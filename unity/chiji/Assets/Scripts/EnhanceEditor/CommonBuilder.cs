using System.Collections;
using System.Collections.Generic;
using UnityEngine;
//using UnityEditor;

namespace xmalloc.EnhanceEditor
{
    public class CommonBuilder : MonoBehaviour
    {
        public GameObject source;

        public Vector3 distance; // 方向上间隔的距离
        public Vector3 direction = new Vector3(1, 0, 0); // 扩展的方向
        public bool useSelfSize;

        public void BuildArray()
        {
            
            Vector3 pos = source.transform.position;
            Vector3 size = source.GetComponent<Collider>().bounds.size;

            Vector3 point = new Vector3(pos.x, pos.y, pos.z);
            for (int i = 0; i <= direction.x; i++)
            {
                for (int j = 0; j <= direction.y; j++)
                {
                    for(int k = 0; k <= direction.z; k++)
                    {
                        createObject(point, new Vector3(i, j, k), size);
                    }
                }

            }

        }

        private void createObject(Vector3 point, Vector3 direction, Vector3 size)
        {
            if(direction.x == 0 && direction.y == 0 && direction.z == 0)
            {
                return;
            }
            print("direction:" + direction);
            if (useSelfSize) {

                point.x += (size.x + distance.x) * direction.x;
                point.y += (size.y + distance.y) * direction.y;
                point.z += (size.z + distance.z) * direction.z;
            } else {

                point.x += (distance.x) * direction.x;
                point.y += (distance.y) * direction.y;
                point.z += (distance.z) * direction.z;
            }
            GameObject newObj = Instantiate(source, point, source.transform.rotation);
            if (source.transform.parent != null)
            {
                newObj.transform.parent = source.transform.parent;
            }

        }
    }


}