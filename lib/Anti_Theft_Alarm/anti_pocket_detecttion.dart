import 'dart:async';
import 'dart:developer';
import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:antitheftalarm/controller/ad_tracking_services.dart';
import 'package:antitheftalarm/controller/analytics_engine.dart';
import 'package:antitheftalarm/controller/tune_manager.dart';
import 'package:antitheftalarm/theme/theme_text.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:antitheftalarm/widgets/native_ad_widget.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:proximity_sensor/proximity_sensor.dart';
import 'package:torch_light/torch_light.dart';
import 'package:vibration/vibration.dart';
import 'package:volume_controller/volume_controller.dart';

class AntiPocketDetection extends StatefulWidget {
  const AntiPocketDetection({super.key});

  @override
  State<AntiPocketDetection> createState() => _AntiPocketDetectionState();
}

class _AntiPocketDetectionState extends State<AntiPocketDetection> {
  bool _flashlight = false;
  bool vibration = false;
  bool isAlarmTriggered = false;
  bool isActivatedPress = false;
  bool _isListening = false;
  bool _hasBeenInPocket = false;
  bool _isActivated = false;
  StreamSubscription<dynamic>? _streamSubscription;

  // for sensor
  bool _isNear = false;

  @override
  void initState() {
    super.initState();
    AdTrackinServices.incrementAdFrequency();
    AnalyticsEngine.logFeatureClicked('Anti_Pocket_Detection');
    Future.microtask(() {
      AdManager.showInterstitialAd(onComplete: () {}, context: context);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription?.cancel();
  }

  void startDetection() {
    setState(() {
      _isActivated = true;
      _isListening = true;
    });
    log('::: Listening started');

    // Start sensor listeners
    _streamSubscription = ProximitySensor.events.listen((int event) {
      setState(() {
        _isNear = (event > 0);

        if (_isNear) {
          if (_isListening) {
            _hasBeenInPocket = true;
          }
        }

        if (_isActivated && _isListening && _hasBeenInPocket && !_isNear) {
          _isListening = false;
          playSound(context, _flashlight, vibration);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    log('::: hasBeenInPocket $_hasBeenInPocket');

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: Themecolor.white,
          child: Column(
            children: [
              NativeAdWidget(
              ),
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
                        'Anti Pocket Detection',
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
                          setState(() {
                            isActivatedPress = true;
                          });
                          if (isAlarmTriggered) {
                            isAlarmTriggered = false;
                          } else {
                            startDetection();
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: Themecolor.black,
                          child: Text(
                            'Activate',
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
                      isActivatedPress
                          ? !_isActivated
                              ? 'Please activate the alarm...'
                              : !_hasBeenInPocket
                                  ? 'Please put it in pocket...'
                                  : 'Activated'
                          : 'Activate',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Press activate button and put on the table directly',
                      style: Themetext.greyColortextstyle,
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
                                    style: BorderStyle.solid))),
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
                                    style: BorderStyle.solid))),
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
                        height: height * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ListTile(
                          leading: Icon(
                            Icons.lightbulb,
                            size: 35,
                            color: Themecolor.white,
                          ),
                          title: Text(
                            'For the best result always turn on vibration when you are in crowded areas and also turn on the flash light',
                            style: Themetext.ctextstyle,
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
      ),
    );
  }

  playSound(BuildContext context, bool torch, bool vibrate) async {
    AnalyticsEngine.logAlarmActivated('Anti_Pocket_Detection');
    String tunePath = TuneManager.getSelectedTune();
    // Set the device volume to maximum
    VolumeController().maxVolume();

    final player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    player.play(AssetSource(tunePath), volume: 1.0);
    await player.resume();

    // Turn on the flashlight
    try {
      if (torch == true) {
        await TorchLight.enableTorch();
      }
    } catch (e) {
      print('Could not enable torch: $e');
    }

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
                setState(() {
                  isActivatedPress = false;
                  _isListening = false;
                  _hasBeenInPocket = false;
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
