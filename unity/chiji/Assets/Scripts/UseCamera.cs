using UnityEngine;
using UnityEngine.UI;
using System.Collections;
using System.IO;
using System.Runtime.Serialization;
using System.Runtime.Serialization.Formatters.Binary;
using System.Threading;
using System.Net;
using System.Text;
using System;
public class UseCamera : MonoBehaviour
{
    public string deviceName;
    //接收返回的图片数据  
    WebCamTexture tex;
    Text info;

    void Start()
    {
        Debug.Log(GameObject.Find("Canvas/Text") == null);
        info = GameObject.Find("Canvas/Text").GetComponent<Text>();

    }


    bool center = true;

    void OnGUI2()
    {
        if (GUI.Button(new Rect(10, 20, 200, 80), "开启摄像头"))
        {
            info.text = "hahaha";
            center = true;
            // 调用摄像头  
            StartCoroutine(start());
        }
        if (GUI.Button(new Rect(10, 110, 200, 80), "捕获照片"))
        {
            info.text = "heiheihei";
            //捕获照片  
            tex.Pause();
            StartCoroutine(getTexture());
        }
        if (GUI.Button(new Rect(10, 200, 200, 80), "再次捕获"))
        {
            //重新开始  
            tex.Play();
        }
        if (GUI.Button(new Rect(10, 290, 200, 80), "录像"))
        {
            //录像  
            StartCoroutine(SeriousPhotoes());
        }
        if (GUI.Button(new Rect(10, 380, 200, 80), "停止"))
        {
            //停止捕获镜头  
            tex.Stop();
            StopAllCoroutines();
        }
        if (GUI.Button(new Rect(10, 470, 200, 80), "换位置"))
        {
            center = false;
        }
        if (GUI.Button(new Rect(10, 560, 200, 80), "保存大片"))
        {
            tex.Pause();
            StartCoroutine(savePic());
        }
        if (tex != null)
        {
            if (center)
            {
                // 捕获截图大小               —距X左屏距离   |   距Y上屏距离    
                GUI.DrawTexture(new Rect(Screen.width / 2 - 150, Screen.height / 2 - 190, 280, 200), tex);
            }
            else
            {
                GUI.DrawTexture(new Rect(Screen.width - 280, Screen.height - 200, 280, 200), tex);
            }
        }


    }
    /// <summary>  
    /// 捕获窗口位置  
    /// </summary>  
    public IEnumerator start()
    {
        yield return Application.RequestUserAuthorization(UserAuthorization.WebCam);
        if (Application.HasUserAuthorization(UserAuthorization.WebCam))
        {
            WebCamDevice[] devices = WebCamTexture.devices;
            
            for(int i = 0; i < devices.Length; i++)
            {
                if (devices[i].isFrontFacing)
                {
                    deviceName = devices[i].name;
                    break;
                }
            }
            //deviceName = devices[0].name;
            info.text = "name:" + deviceName;
            tex = new WebCamTexture(deviceName, 1280, 720, 12);
            tex.Play();
            
        }
    }
    /// <summary>  
    /// 获取截图  
    /// </summary>  
    /// <returns>The texture.</returns>  
    public IEnumerator getTexture()
    {
        yield return new WaitForEndOfFrame();
        Texture2D t = new Texture2D(400, 300);
        t.ReadPixels(new Rect(Screen.width / 2 - 200, Screen.height / 2 - 50, 360, 300), 0, 0, false);
        //距X左的距离        距Y屏上的距离  
        // t.ReadPixels(new Rect(220, 180, 200, 180), 0, 0, false);  
        t.Apply();
        byte[] byt = t.EncodeToPNG();
        info.text = Application.persistentDataPath;
        UploadFile(byt, "self");
        File.WriteAllBytes(Application.persistentDataPath + "/" + Time.time + ".jpg", byt);
        //tex.Play();
    }
    public IEnumerator savePic()
    {
        yield return new WaitForEndOfFrame();
        Texture2D t = new Texture2D(1280, 720);
        t.SetPixels(tex.GetPixels());
        t.Apply();
        byte[] byt = t.EncodeToPNG();
        File.WriteAllBytes(Application.persistentDataPath + "/" + Time.time + ".jpg", byt);
    }
    /// <summary>  
    /// 连续捕获照片  
    /// </summary>  
    /// <returns>The photoes.</returns>  
    public IEnumerator SeriousPhotoes()
    {
        while (true)
        {
            yield return new WaitForEndOfFrame();
            Texture2D t = new Texture2D(400, 300, TextureFormat.RGB24, true);
            t.ReadPixels(new Rect(Screen.width / 2 - 180, Screen.height / 2 - 50, 360, 300), 0, 0, false);
            t.Apply();
            print(t);
            byte[] byt = t.EncodeToPNG();
            File.WriteAllBytes(Application.dataPath + "/MulPhotoes/" + Time.time.ToString().Split('.')[0] + "_" + Time.time.ToString().Split('.')[1] + ".png", byt);
            Thread.Sleep(300);
        }
    }

    /// <summary>
    /// Http上传文件
    /// </summary>
    public static string UploadFile(/*string url, */byte[] fileData, string type)
    {
        string url = "http://182.92.83.14:6024/game/pic/save";
        // 设置参数
        HttpWebRequest request = WebRequest.Create(url) as HttpWebRequest;
        CookieContainer cookieContainer = new CookieContainer();
        request.CookieContainer = cookieContainer;
        request.AllowAutoRedirect = true;
        request.Method = "POST";
        string boundary = DateTime.Now.Ticks.ToString("X"); // 随机分隔线
        request.ContentType = "multipart/form-data;charset=utf-8;boundary=" + boundary;
        byte[] itemBoundaryBytes = Encoding.UTF8.GetBytes("\r\n--" + boundary + "\r\n");
        byte[] endBoundaryBytes = Encoding.UTF8.GetBytes("\r\n--" + boundary + "--\r\n");

        //int pos = path.LastIndexOf("\\");
        //string fileName = path.Substring(pos + 1);
        string fileName = boundary + ".png";


        string paramTemplate = "\r\n--" + boundary + "\r\nContent-Disposition: form-data; name=\"{0}\";\r\n\r\n{1}";

        //请求头部信息
        StringBuilder sbHeader = new StringBuilder(string.Format("Content-Disposition:form-data;name=\"upload\";filename=\"{0}\"\r\nContent-Type:application/octet-stream\r\n\r\n", fileName));
        byte[] postHeaderBytes = Encoding.UTF8.GetBytes(sbHeader.ToString());

        //FileStream fs = new FileStream(path, FileMode.Open, FileAccess.Read);
        //byte[] bArr = new byte[fs.Length];
        //fs.Read(bArr, 0, bArr.Length);
        //fs.Close();

        

        Stream postStream = request.GetRequestStream();

        byte[] paramBytes = Encoding.UTF8.GetBytes(string.Format(paramTemplate, "pass", "123456"));
        postStream.Write(paramBytes, 0, paramBytes.Length);
        paramBytes = Encoding.UTF8.GetBytes(string.Format(paramTemplate, "type", type));
        postStream.Write(paramBytes, 0, paramBytes.Length);

        postStream.Write(itemBoundaryBytes, 0, itemBoundaryBytes.Length);
        postStream.Write(postHeaderBytes, 0, postHeaderBytes.Length);
        postStream.Write(fileData, 0, fileData.Length);
        postStream.Write(endBoundaryBytes, 0, endBoundaryBytes.Length);
        postStream.Close();

        //发送请求并获取相应回应数据
        HttpWebResponse response = request.GetResponse() as HttpWebResponse;
        //直到request.GetResponse()程序才开始向目标网页发送Post请求
        Stream instream = response.GetResponseStream();
        StreamReader sr = new StreamReader(instream, Encoding.UTF8);
        //返回结果网页（html）代码
        string content = sr.ReadToEnd();
        return content;
    }
}