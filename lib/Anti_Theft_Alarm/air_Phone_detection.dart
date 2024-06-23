import 'package:antitheftalarm/widgets/native_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:headset_connection_event/headset_event.dart';
import 'package:torch_light/torch_light.dart';
import 'package:vibration/vibration.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:antitheftalarm/theme/theme_text.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:antitheftalarm/controller/tune_manager.dart';
import 'package:antitheftalarm/controller/analytics_engine.dart';
import 'package:antitheftalarm/controller/ad_tracking_services.dart';
import 'package:antitheftalarm/controller/ad_manager.dart';

class AirphonesDetection extends StatefulWidget {
  const AirphonesDetection({Key? key}) : super(key: key);

  @override
  State<AirphonesDetection> createState() => _AirphonesDetectionState();
}

class _AirphonesDetectionState extends State<AirphonesDetection> {
  bool _flashlight = false;
  bool vibration = false;
  bool isActivatedPress = false;
  bool isHeadsetConnected = false;
  bool isAlarmTriggered = false;
  bool isAlarmPlaying = false;
  final player = AudioPlayer();
  late BuildContext alarmDialogContext; // To keep track of dialog context

  final _headsetPlugin = HeadsetEvent();
  HeadsetState? headsetState;

  @override
  void initState() {
    super.initState();

    _headsetPlugin.requestPermission();
    _initHeadsetState();
  }

  void _initHeadsetState() {
    _headsetPlugin.getCurrentState.then((currentState) {
      setState(() {
        headsetState = currentState;
        isHeadsetConnected = currentState == HeadsetState.CONNECT;
      });
    });

    _headsetPlugin.setListener((newState) {
      setState(() {
        headsetState = newState;
        isHeadsetConnected = newState == HeadsetState.CONNECT;

        if (isActivatedPress &&
            newState == HeadsetState.DISCONNECT &&
            !isAlarmPlaying) {
          _triggerAlarm();
        } else if (newState == HeadsetState.CONNECT) {
          _stopAlarm();
        }
      });
    });

    AdTrackinServices.incrementAdFrequency();
    AnalyticsEngine.logFeatureClicked('head_set_detected');
    Future.microtask(() {
      AdManager.showInterstitialAd(onComplete: () {}, context: context);
    });
  }

  void _triggerAlarm() {
    if (!isActivatedPress || isAlarmTriggered) return;

    setState(() {
      isAlarmTriggered = true;
      isAlarmPlaying = true;
    });

    _playAlarm();
  }

  void _playAlarm() async {
    AnalyticsEngine.logAlarmActivated('head_set_alarm');
    String tunePath = TuneManager.getSelectedTune();
    VolumeController().maxVolume();

    player.setReleaseMode(ReleaseMode.stop);
    await player.play(AssetSource(tunePath), volume: 1.0);

    try {
      if (_flashlight) {
        await TorchLight.enableTorch();
      }
    } catch (e) {
      print('Could not enable torch: $e');
    }

    if (vibration) {
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
          255,
        ],
      );
    }

    // Show alert dialog to stop the sound
    _showStopDialog();
  }

  void _stopAlarm() async {
    if (!isAlarmPlaying) return;

    setState(() {
      isActivatedPress = false;
      isAlarmTriggered = false;
      isAlarmPlaying = false;
    });

    await player.stop();
    await TorchLight.disableTorch();
    Vibration.cancel();

    // Dismiss the dialog if it's open
    Navigator.of(alarmDialogContext).pop();
  }

  void _showStopDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // Keep the context to dismiss the dialog later
        alarmDialogContext = context;

        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text('Alarm Playing'),
            content: Text('The alarm is playing. Do you want to stop it?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _stopAlarm();
                },
                child: Text('Stop Alarm'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    player.dispose(); // Dispose of the audio player when no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            NativeAdWidget(),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Themecolor.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Earphone\'s Detection',
                      style: Themetext.atextstyle.copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (isHeadsetConnected && !isAlarmTriggered) {
                          setState(() {
                            isActivatedPress = true;
                          });
                          _showSnackbar('Alarm activated');
                        } else if (!isHeadsetConnected) {
                          _showSnackbar('Connect earphones to activate');
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: Themecolor.black,
                        child: Text(
                          isActivatedPress ? 'Activated' : 'Activate',
                          style: Themetext.ctextstyle,
                        ),
                        maxRadius: 45,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(
                    isHeadsetConnected
                        ? 'Earphones connected'
                        : 'Earphones not connected',
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: height * 0.07,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: const Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          )),
                      child: ListTile(
                        leading: Icon(
                          Icons.lightbulb_outlined,
                          size: 30,
                        ),
                        title: Text(
                          'Flash light',
                          style: Themetext.atextstyle,
                        ),
                        trailing: Switch(
                          value: _flashlight,
                          onChanged: (value) {
                            setState(() {
                              _flashlight = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: height * 0.07,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          )),
                      child: ListTile(
                        leading: Icon(
                          Icons.vibration,
                          size: 30,
                        ),
                        title: Text(
                          'Vibrate',
                          style: Themetext.atextstyle,
                        ),
                        trailing: Switch(
                          value: vibration,
                          onChanged: (value) {
                            setState(() {
                              vibration = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.lightbulb,
                          size: 35,
                          color: Themecolor.white,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'For the best result always turn on vibration when you are in crowded areas and also turn on the flashlight',
                              style: Themetext.ctextstyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void playSound(BuildContext context, bool torch, bool vibrate) async {
    AnalyticsEngine.logAlarmActivated('Do_not_touch_my_phone');
    String tunePath = TuneManager.getSelectedTune();
    // Set the device volume to maximum
    VolumeController().maxVolume();

    player.setReleaseMode(ReleaseMode.stop);
    player.play(AssetSource(tunePath), volume: 1.0);
    // await player.setSource(AssetSource('alarm.mp3'));
    await player.resume();

    // Turn on the flashlight
    try {
      if (torch) {
        await TorchLight.enableTorch();
      }
    } catch (e) {
      print('Could not enable torch: $e');
    }

    if (vibrate) {
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
                setState(() {
                  isActivatedPress = false;
                });
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
}
