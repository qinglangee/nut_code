using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;
using System;

public class HomeCtrl : MonoBehaviour, IPointerDownHandler {

    public GameObject info;

	// Use this for initialization
	void Start () {

		if(gameObject.name == "Start")
        {
            info.SetActive(false);
            if (!Application.HasUserAuthorization(UserAuthorization.WebCam))
            {
                info.GetComponent<Text>().text = "no per";
                info.SetActive(true);
                gameObject.SetActive(false);
            }
            else
            {
                WebCamDevice[] devices = WebCamTexture.devices;
                String exp = "  ";
                try
                {
                    string deviceName = "{}";
                    WebCamTexture tex;
                    for (int i = 0; i < devices.Length; i++)
                    {
                        if (devices[i].isFrontFacing)
                        {
                            deviceName = devices[i].name;
                            break;
                        }
                    }
                    //deviceName = devices[0].name;
                    //info.text = "name:" + deviceName;
                    if (devices.Length > 0)
                    {
                        tex = new WebCamTexture(deviceName, 1280, 720, 3);
                        //tex.Play();
                    }
                }catch(Exception e)
                {
                    exp += e.Message;
                }


                info.GetComponent<Text>().text = "has per  " + devices.Length + exp;
            }

            StartCoroutine(checkMicrophone());

            
        }
	}

    public IEnumerator checkMicrophone()
    {
        yield return Application.RequestUserAuthorization(UserAuthorization.Microphone);
        if (Application.HasUserAuthorization(UserAuthorization.Microphone))
        {
        }
    }






    public void OnPointerDown(PointerEventData data)
    {
        switch (gameObject.name)
        {
            case "Start":
                SceneLoad();
                break;
            case "Quit":
                QuitGame();
                break;
        }
    }

    // 加载关卡
    public void SceneLoad()
    {
        SceneManager.LoadScene("S02Monster");
    }

    public void QuitGame()
    {
        #if UNITY_EDITOR
            UnityEditor.EditorApplication.isPlaying = false;
            Debug.Log("编辑状态游戏退出");
        #else
            Application.Quit();
            Debug.Log ("游戏退出");
        #endif
    }
}
