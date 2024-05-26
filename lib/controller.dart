import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';
import 'package:vibration/vibration.dart';
import 'package:volume_controller/volume_controller.dart';

playSound(BuildContext context, bool torch ,bool vibrate) async {
  // Set the device volume to maximum
  VolumeController().maxVolume();

  final player = AudioPlayer();
  player.setReleaseMode(ReleaseMode.stop);
  player.play(AssetSource('alarm.mp3'), volume: 1.0);
  // await player.setSource(AssetSource('alarm.mp3'));
  await player.resume();

  // Turn on the flashlight
  try {
    if (torch == true) {
      await TorchLight.enableTorch();
    }
  } catch (e) {
    print('Could not enable torch: $e');
  }
  // var hasVibrator = await Vibration.hasVibrator();
  // // Vibrate the device
  // if (hasVibrator != null) {
  //   if (hasVibrator) {
  //     Vibration.vibrate();
  //   }
  // }
  if (vibrate == true) {
    Vibration.vibrate(
      pattern: [
        500,
        1000,
        500,
        2000,
        500,
        3000,
        500,
        500,
        500,
        1000,
        500,
        2000,
        500,
        3000,
        500,
        500,
        500,
        1000,
        500,
        2000,
        500,
        3000,
        500,
        500,
      ],
      intensities: [
        0,
        128,
        0,
        255,
        0,
        64,
        0,
        255,
        0,
        128,
        0,
        255,
        0,
        64,
        0,
        255,
        0,
        128,
        0,
        255,
        0,
        64,
        0,
        255
      ],
    );
  }

  // Show alert dialog to stop the sound
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alarm Playing'),
        content: Text('The alarm is playing. Do you want to stop it?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await player.stop();
              await TorchLight.disableTorch();
              Vibration.cancel();
              Navigator.of(context).pop();
            },
            child: Text('Stop Alarm'),
          ),
        ],
      );
    },
  );
}
