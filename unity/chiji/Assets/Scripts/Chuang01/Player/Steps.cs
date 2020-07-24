using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using Hellmade.Sound;
namespace xmalloc.chuang {
    // 剧情信息
    public class Steps {
        private static Steps instance;
        public StepLine mainSteps;


        private Steps() {
            mainSteps = createMainStep();
        }
        public static Steps GetInstance() {
            if(instance == null) {
                instance = new Steps();
            }
            return instance;
        }

        private StepLine createMainStep() {
            StepLine steps = new StepLine();
            List<StepInfo> list = new List<StepInfo>();
            float step = 0;
            list.Add(new StepInfo(step++, "终于等到你了！\n我这里有本秘籍要不要学一下呀", "想学呀", "不想学", "001hello", "003food", "004goaway"));
            list.Add(new StepInfo(step++, "来，我看看采了多少果子。", "给你，够撑死你了。", "别急，还得再采些呢"));

            Dictionary<float, StepInfo> map = new Dictionary<float, StepInfo>();

            foreach(StepInfo info in list) {
                steps.map.Add(info.step, info);
            }
            return steps;
        }

        
    }

    public class StepLine {
        public Dictionary<float, StepInfo> map = new Dictionary<float, StepInfo>();

        public StepInfo GetStepInfo(float step) {
            StepInfo value;
            map.TryGetValue(step, out value);
            return value;
        }
    }

    public class StepInfo {
        public float step;
        public string[] messages;
        public string okBtn;
        public string cancelBtn;

        public string audioFile; // 进入时就播放
        public string okAudioFile;
        public string cancelAudioFile;

        public Audio audio;
        public Audio okAudio;
        public Audio cancelAudio;

        public StepInfo(float step, string msg, string okText, string cancelText = "白白了") {
            string[] messages = new string[] { msg };
            SetUp(step, messages, okText, cancelText);
        }
        public StepInfo(float step, string[] msgs, string okText, string cancelText = "白白了") {

            SetUp(step, msgs, okText, cancelText);
        }
        public StepInfo(float step, string[] msgs, string okText, string cancelText, string audio, string okAudio, string calcelAudio) {

            SetUp(step, msgs, okText, cancelText);
        }

        public StepInfo(float step, string msg, string okText, string cancelText, string audio, string okAudio, string cancelAudio) {
            string[] msgs = new string[] { msg };
            SetUp(step, msgs, okText, cancelText, audio, okAudio, cancelAudio);
        }

        private void SetUp(float step, string[] msgs, string okText, string cancelText) {
            SetUp(step, msgs, okText, cancelText, null, null, null);
        }
        private void SetUp(float step, string[] msgs, string okText, string cancelText, string audio, string okAudio, string cancelAudio) {
            this.step = step;
            messages = msgs;
            okBtn = okText;
            cancelBtn = cancelText;
            this.audioFile = audio;
            this.okAudioFile = okAudio;
            this.cancelAudioFile = cancelAudio;
        }
    }
}
