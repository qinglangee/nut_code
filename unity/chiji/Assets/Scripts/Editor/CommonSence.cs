using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

namespace xmalloc.EnhanceEditor
{
    [CustomEditor(typeof(CommonBuilder))]
    public class CommonSence : Editor
    {
        public Vector3 direction;

        public override void OnInspectorGUI()
        {
            DrawDefaultInspector();
            CommonBuilder myScript = (CommonBuilder)target;
            if (GUILayout.Button("Build Object"))
            {
                myScript.BuildArray();
            }
        }
    }

}
