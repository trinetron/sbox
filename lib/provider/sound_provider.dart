import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:sbox/models/sound/sound_sheme.dart';

class SoundProvider extends ChangeNotifier {
  static AudioPlayer player = AudioPlayer();
  static SoundSHM bSound = SoundSHM();
  bool soundOn = false;

  void sndOn(bool sOn) {
    soundOn = sOn;
  }

  void playSound(var snd) async {
    if (soundOn) {
      await player.setReleaseMode(ReleaseMode.release);

      switch (snd) {
        case 'menu':
          debugPrint('snd_menu');
          await player.setSourceAsset(bSound.snd_menu);
          await player.resume();

          break;
        case 'button':
          await player.setSourceAsset(bSound.snd_button);
          await player.resume();
          break;
        case 'save':
          await player.setSourceAsset(bSound.snd_save);
          await player.resume();
          break;
        case 'err':
          await player.setSourceAsset(bSound.snd_err);
          await player.resume();
          break;
      }
    }
  }
}
