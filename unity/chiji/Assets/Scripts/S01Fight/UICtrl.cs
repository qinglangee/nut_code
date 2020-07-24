using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;
using UnityEngine.EventSystems;
using UnityEditor;

public class UICtrl : MonoBehaviour, IPointerDownHandler {

    public GameObject photoOK;
    public GameObject photoCancel;
    GameObject heroPhoto;

    Image image;

    public TakePhoto tp;
    // Use this for initialization
    void Start () {

        if(photoOK != null && photoCancel != null)
        {
            photoOK.SetActive(false);
            photoCancel.SetActive(false);
        }

        heroPhoto = GameObject.Find("HeroPhoto");
    }
	
	// Update is called once per frame
	void Update () {
		
	}

	public void OnPointerDown(PointerEventData data){
        //print("click  lala");
		switch(gameObject.name){
			case "Fire":
				print("fire down");
				break;
			case "Reload":
				SceneReload();
				break;
            case "PhotoOK":
                PhotoOK();
                break;
            case "PhotoCancel":
                PhotoCancel();
                break;
		}
	}
    // 启载关卡
	void SceneReload(){
		SceneManager.LoadScene(SceneManager.GetActiveScene().name);
	}

    // 拍照完成
    void PhotoOK()
    {
        //print("click ok");
        photoOK.SetActive(false);
        photoCancel.SetActive(false);

        tp.SaveHeroPhoto();
    }
    // 拍照取消
    void PhotoCancel()
    {
        //print("click cancel");
        photoOK.SetActive(false);
        photoCancel.SetActive(false);

        tp.SavePhoto();

        //Texture2D t = (Texture2D)Resources.Load("Assets/Images/HeroPhoto.png", typeof(Texture2D));


        //heroPhoto.GetComponent<MeshRenderer>().material.mainTexture = t;
    }
}
