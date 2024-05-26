
  import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:volume_controller/volume_controller.dart';

playSound(BuildContext context) async {
    // Set the device volume to maximum
    VolumeController().maxVolume();

    final player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    player.play(AssetSource('alarm.mp3'), volume: 1.0);
    // await player.setSource(AssetSource('alarm.mp3'));
    await player.resume();
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
                Navigator.of(context).pop();
              },
              child: Text('Stop Alarm'),
            ),
          ],
        );
      },
    );
  }
