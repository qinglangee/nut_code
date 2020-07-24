using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using UnityEditor;
using UnityEngine.UI;

public class HeroBar : MonoBehaviour
{
    public Text info;
    public WebCamTexture tex;




    public EnemySpawn spawner;

    GameObject heroPhoto;

    public GameObject photoOK;
    public GameObject photoCancel;

    // Use this for initialization
    void Start () {

        //Texture2D t = (Texture2D)AssetDatabase.LoadAssetAtPath("Assets/Images/up.png", typeof(Texture2D));
        //GameObject.Find("photo").GetComponent<MeshRenderer>().material.mainTexture = t;


        heroPhoto = GameObject.Find("HeroPhoto");

        //photoOK = GameObject.Find("PhotoOK");
        //photoCancel = GameObject.Find("PhotoCancel");


        //StartCoroutine(start());

    }


    public IEnumerator start()
    {
        yield return Application.RequestUserAuthorization(UserAuthorization.WebCam);
        if (Application.HasUserAuthorization(UserAuthorization.WebCam))
        {
            string deviceName = "no name";
            WebCamDevice[] devices = WebCamTexture.devices;
            info.text = "001:" + deviceName;
            for (int i = 0; i < devices.Length; i++)
            {
                if (devices[i].isFrontFacing)
                {
                    deviceName = devices[i].name;
                    break;
                }
            }

            info.text = "002:" + deviceName;
            //deviceName = devices[0].name;
            info.text = "name:" + deviceName;
            if (devices.Length > 0)
            {

                info.text = "003:" + deviceName;
                tex = new WebCamTexture(deviceName, 1280, 720, 3);
                tex.Play();
            }

        }
        else
        {

            info.text = "005:";
        }

        heroPhoto.GetComponent<MeshRenderer>().material.mainTexture = tex;
    }

    // Update is called once per frame
    void Update () {
		
	}

    int count = 0;
    public void Hurt(float count)
    {
        info.text = "count: " + count;
        count++;
        if(spawner.liveCount > 100)
        {
            return;
        }

        photoOK.SetActive(true);
        photoCancel.SetActive(true);

        heroPhoto.GetComponent<MeshRenderer>().material.mainTexture = spawner.tp.tex;




    }
}
