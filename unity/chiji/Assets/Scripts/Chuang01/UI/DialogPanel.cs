using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


using Hellmade.Sound;
using xmalloc.Util;
namespace xmalloc.chuang {

    public class DialogPanel : MonoBehaviour {
        public Button okBtn;
        public Button cancelBtn;
        public Text stepMsg;


        Text okText;
        Text cancelText;
        

        PlayerInfo playerInfo;
        Steps steps;

        StepInfo stepInfo;

        Log log;
        // Use this for initialization
        void Awake() {
            log = new Log(gameObject);
            okText = okBtn.transform.Find("Text").GetComponent<Text>();
            cancelText = cancelBtn.transform.Find("Text").GetComponent<Text>();


            playerInfo = Global.GetPlayerInfo();
            steps = Steps.GetInstance();


            log.d("start  steps null" + (steps == null) + "  playerInfo null " + (playerInfo == null));
            bindEvent();

        }

        // Update is called once per frame
        void Update() {

        }

        public void bindEvent() {
            okBtn.onClick.AddListener(delegate () { OkClick(okBtn.gameObject); });
            cancelBtn.onClick.AddListener(delegate () { CancelClick(cancelBtn.gameObject); });
        }

        private void OkClick(GameObject obj) {
            if (stepInfo.audio != null) {
                stepInfo.audio.Stop();
            }
            stepInfo.okAudio = playAudio(stepInfo.okAudioFile, stepInfo.okAudio);
            playerInfo.Step += 1;
            showStep();
        }

        private void CancelClick(GameObject obj) {
            if(stepInfo.audio != null) {
                stepInfo.audio.Stop();
            }
            log.d( "naem:" + obj.name +" stepinfo null: " + (stepInfo == null) + "  " );
            stepInfo.cancelAudio = playAudio(stepInfo.cancelAudioFile, stepInfo.cancelAudio);

            ClosePanel();
        }

        public void showStep() {

            gameObject.SetActive(true);

            stepInfo = steps.mainSteps.GetStepInfo(playerInfo.Step);
            if(stepInfo == null) {
                ClosePanel();
                return;
            }

            okText.text = stepInfo.okBtn;
            cancelText.text = stepInfo.cancelBtn;
            stepInfo.audio = playAudio(stepInfo.audioFile, stepInfo.audio);

            if(stepInfo.messages != null && stepInfo.messages.Length > 0) {

                stepMsg.text = stepInfo.messages[0];
            }

        }

        private Audio playAudio(string path, Audio audio) {
            if(path == null) {
                return null;
            }
            if(audio == null) {
                AudioClip audioClip = Resources.Load<AudioClip>("Audios/" + path);
                int audioID = EazySoundManager.PlaySound(audioClip, 1f, false, null);
                audio = EazySoundManager.GetSoundAudio(audioID);
            } else {
                if (!audio.IsPlaying) {

                    audio.Play();
                }
            }
            return audio;
        }

        public void ClosePanel() {
            gameObject.SetActive(false);
        }
    }
}
