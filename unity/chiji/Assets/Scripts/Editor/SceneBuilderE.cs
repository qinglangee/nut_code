using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(SceneBuilder))]
public class SceneBuilderE : Editor {

	public override void OnInspectorGUI()
    {
        DrawDefaultInspector();
        SceneBuilder myScript = (SceneBuilder)target;
        if(GUILayout.Button("Build Object"))
        {
            myScript.BuildPlane();
        }
    }
}
