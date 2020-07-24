using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class SceneBuilder : MonoBehaviour {

    public GameObject obj;
    public GameObject edge;
    public Vector3 spawnPoint;

    
    public void BuildPlane()
    {
        GameObject planeParent = GameObject.FindWithTag("PlaneParent") ;
        if (planeParent != null)
        {
            DestroyImmediate(planeParent); // 这个是不能回退的删除操作
            //UnityEditor.Undo.DestroyObjectImmediate(planeParent); // 这个是可以回退的删除操作
        }
        Vector3 point;
        int row = 20;
        int line = 30;
        for(int i = 0; i < row; i++)
        {
            for (int j = 0; j < line; j++)
            {
                point = new Vector3(i * 5, 0, j * 5);
                GameObject newObj = Instantiate(obj, point, Quaternion.identity);
                if(i==0 && j == 0)
                {
                    planeParent = newObj;
                    planeParent.tag = "PlaneParent";
                }
                else
                {
                    newObj.transform.parent = planeParent.transform;

                }

                if (i == 0)
                {
                    createPlane(new Vector3(-2.5f, 2.5f, j * 5), edge, Quaternion.LookRotation(Vector3.forward, Vector3.right), planeParent);
                    createPlane(new Vector3(row *5-2.5f, 2.5f, j * 5), edge, Quaternion.LookRotation(Vector3.forward, Vector3.left), planeParent);
                }
            }
            // 内墙
            createPlane(new Vector3(i * 5, -2.5f, -2.5f), obj, Quaternion.LookRotation(Vector3.up, Vector3.back), planeParent);
            createPlane(new Vector3(i * 5, 2.5f, 5*line-2.5f), edge, Quaternion.LookRotation(Vector3.up, Vector3.back), planeParent);
            // 外墙
            createPlane(new Vector3(i * 5, -2.5f, -2.5f-5), edge, Quaternion.LookRotation(Vector3.down, Vector3.forward), planeParent);
            // 底下
            createPlane(new Vector3(i * 5, -5f, -5f), obj, Quaternion.identity, planeParent);
            
        }
    }

    private void createPlane(Vector3 point, GameObject obj, Quaternion dir, GameObject parent)
    {
        GameObject newObj = Instantiate(obj, point, dir);
        newObj.transform.parent = parent.transform;
    }
	
}
