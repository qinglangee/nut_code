using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using Hellmade.Sound;
namespace xmalloc.Util {

    public class ObjAudio{
        Dictionary<string, Audio> map;
        
        public ObjAudio() {
            map = new Dictionary<string, Audio>();
        }

        public void PlaySound(string name, AudioClip clip) {
            if(clip == null) {
                return;
            }
            Audio audio;
            map.TryGetValue(name, out audio);
            if(audio == null) {
                int audioId = EazySoundManager.PlaySound(clip);
                audio = EazySoundManager.GetSoundAudio(audioId);
                map.Add(name, audio);
            } else {
                audio.Play();
            }
        }

        public void PlaySoundWithPath(string audioPath) {
            Audio audio;
            map.TryGetValue(audioPath, out audio);
            if (audio == null) {
                AudioClip clip = Resources.Load<AudioClip>(audioPath);
                int audioId = EazySoundManager.PlaySound(clip);
                audio = EazySoundManager.GetSoundAudio(audioId);
                map.Add(audioPath, audio);
            } else {
                audio.Play();
            }
        }

        public void PlaySound(string name) {
            string path = AudioDict.GetAudioPath(name);
            if(path == null) {
                return;
            }
            PlaySoundWithPath(path);
        }
    }

    public class AudioDict {
        private static Dictionary<string, string> map;
        public static string GetAudioPath(string name) {
            string path = null;
            if(map == null) {
                initMap();
            }
            map.TryGetValue(name, out path);
            return path;
        }

        private static void initMap(){
            map = new Dictionary<string, string>();
            map.Add("GetItem", "Audios/GetItem");
            map.Add("HitWood", "Audios/005fist_wood");

            //  UI
            map.Add("Land", "Audios/UI/Land");

            // Player
            map.Add("LevelUp", "Audios/Player/LevelUp");

        }
    }
}
