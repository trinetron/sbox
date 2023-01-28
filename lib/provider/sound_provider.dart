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
    player.setReleaseMode(ReleaseMode.release);

    switch (snd) {
      case 'menu':
        if (soundOn) {
          debugPrint('snd_menu');
          await player.setSourceAsset(bSound.snd_menu);
          await player.resume();
        }
        break;
      case 'button':
        player.setSourceAsset(bSound.snd_button);
        player.resume();
        break;
      case 'save':
        player.setSourceAsset(bSound.snd_save);
        player.resume();
        break;
      case 'err':
        player.setSourceAsset(bSound.snd_err);
        player.resume();
        break;
    }
  }
}
