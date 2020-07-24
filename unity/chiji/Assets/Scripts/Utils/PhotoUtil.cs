using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Threading;
using System;
using System.Text;
using UnityEngine;
using UnityEngine.UI;

namespace xmalloc.Util
{
    public class PhotoUtil : MonoBehaviour
    {
        public Text info;


        public WebCamTexture tex;

        bool saving = false;
        bool playing = false;

        private byte[] picBytes;

        private int camWidth = 800;
        private int camHeight = 800;


        GameObject heroPhoto;

        // Use this for initialization
        void Start()
        {
            heroPhoto = GameObject.Find("HeroPhoto");
        }

        // Update is called once per frame
        void Update()
        {
            //info.text = "playing:" + playing + "  saving:" + saving;
        }

        public bool StartCam()
        {
            if (tex != null && tex.isPlaying)
            {
                return true;
            }
            if (tex == null)
            {
                StartCoroutine(start());
            }
            return false;
        }

        public void SaveHeroPhoto()
        {
            SaveHeroPhotoAndUpload();
        }

        public void SaveHeroPhotoAndUpload()
        {

            //tex.Pause();
            saving = true;

            Texture2D t = new Texture2D(camWidth, camHeight);
            t.SetPixels(tex.GetPixels());
            t.Apply();
            picBytes = t.EncodeToPNG();

            heroPhoto.GetComponent<MeshRenderer>().material.mainTexture = t;


            Thread saveThread = new Thread(new ThreadStart(saveSelfPic));
            saveThread.Start();
        }

        public void SavePhoto()
        {
            if (saving)
            {
                return;
            }
            //tex.Pause();
            saving = true;



            Texture2D t = new Texture2D(camWidth, camHeight);
            t.SetPixels(tex.GetPixels());
            t.Apply();
            picBytes = t.EncodeToPNG();
            Thread saveThread = new Thread(new ThreadStart(savePic));
            saveThread.Start();
        }


        private void saveSelfPic()
        {

            File.WriteAllBytes(Application.persistentDataPath + "/" + "hero.png", picBytes);

            //yield return new WaitForFixedUpdate();
            UploadFile(picBytes, "self");
            //File.WriteAllBytes(Application.persistentDataPath + "/" + Time.time + ".png", byt);
            saving = false;
        }

        private void savePic()
        {
            //yield return new WaitForFixedUpdate();
            UploadFile(picBytes, "selfnana");
            //File.WriteAllBytes(Application.persistentDataPath + "/" + Time.time + ".png", byt);
            saving = false;
        }

        public IEnumerator start()
        {
            yield return Application.RequestUserAuthorization(UserAuthorization.WebCam);
            if (Application.HasUserAuthorization(UserAuthorization.WebCam))
            {
                string deviceName = "no name";
                WebCamDevice[] devices = WebCamTexture.devices;

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
                    tex = new WebCamTexture(deviceName, camWidth, camHeight, 3);
                    tex.Play();
                    playing = true;
                }

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

}
