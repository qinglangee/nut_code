using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using UnityStandardAssets.CrossPlatformInput;

using xmalloc.Util;
namespace Stage02
{
    public class Player : MonoBehaviour
    {
        public float health = 100f;
        PhotoUtil photoUtil;
        StageInfo stageInfo = StageInfo.GetInstance();
        GameObject heroPhoto;
        // Use this for initialization
        void Start()
        {
            photoUtil = new PhotoUtil();
            heroPhoto = GameObject.Find("HeroPhoto");
        }

        // Update is called once per frame
        void FixedUpdate()
        {
            bool fire = CrossPlatformInputManager.GetButtonDown("Fire1");
        }

        public void Hurt(float power)
        {
            health -= power;
        }

        // 处理各种trigger
        private void OnTriggerEnter(Collider other)
        {
            string name = other.gameObject.name;

            if(name == "P01In")
            {
                stageInfo.point01 = true;
            }else if(name == "P01Out")
            {
                stageInfo.point01 = false;
            }else if(name == "PhotoSwitch")
            {
                photoUtil.StartCam();
            }else if(name == "PhotoTake")
            {
                heroPhoto.GetComponent<MeshRenderer>().material.mainTexture = photoUtil.tex;
            }
            else if (name.StartsWith("PhotoTriger"))
            {
                photoUtil.SavePhoto();
            }
        }
    }

}
