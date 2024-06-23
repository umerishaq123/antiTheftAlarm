import 'dart:async';
import 'dart:math';
import 'package:antitheftalarm/widgets/native_ad_widget.dart';
import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:antitheftalarm/controller/ad_tracking_services.dart';
import 'package:antitheftalarm/controller/analytics_engine.dart';
import 'package:antitheftalarm/controller/tune_manager.dart';
import 'package:antitheftalarm/theme/theme_text.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:torch_light/torch_light.dart';
import 'package:vibration/vibration.dart';
import 'package:volume_controller/volume_controller.dart';

class DonotTouchPhone extends StatefulWidget {
  const DonotTouchPhone({super.key});

  @override
  State<DonotTouchPhone> createState() => _DonotTouchPhoneState();
}

class _DonotTouchPhoneState extends State<DonotTouchPhone> {
  bool _flashlight = false;
  bool vibration = false;
  double _sensitivityValue = 0.5;
  double _threshold = 12.0; // Adjust the threshold for sensitivity
  StreamSubscription<AccelerometerEvent>? subscription;
  bool isAlarmTriigered = false;
  bool isActivatedPress = false;

  @override
  void initState() {
    super.initState();

    AnalyticsEngine.logFeatureClicked('Do_not_touch_my_phone');
    AdTrackinServices.incrementAdFrequency();
    Future.microtask(() {
      AdManager.showInterstitialAd(onComplete: () {}, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Themecolor.white),
      ),
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
                        'Donnot touch my phone',
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
                        if (isAlarmTriigered == true) {
                          isAlarmTriigered = false;
                        } else {
                          subscription = accelerometerEvents
                              .listen((AccelerometerEvent event) {
                            double totalAcceleration = sqrt(event.x * event.x +
                                event.y * event.y +
                                event.z * event.z);
                            if (totalAcceleration > _threshold) {
                              if (isAlarmTriigered == false) {
                                isAlarmTriigered = true;
                                print('::: play sound');
                                playSound(
                                  context,
                                  _flashlight,
                                  vibration,
                                );
                              }
                            }
                          });
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
                    )),
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // height: height * 0.15,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black26),
                            color: Themecolor.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ListTile(
                          leading: Icon(
                            Icons.vibration,
                            size: 35,
                          ),
                          title: Text(
                            'Motion Alarm Sensitivity',
                            style: Themetext.atextstyle,
                          ),
                          subtitle: Column(
                            children: [
                              Text(
                                'Please adjust  sensitivity for motion detection ',
                                style: Themetext.greyColortextstyle,
                              ),
                              Slider(
                                value: _sensitivityValue,
                                min: 0,
                                max: 1,
                                divisions: 8,
                                label: (20 - (_sensitivityValue * 8))
                                    .round()
                                    .toString(),
                                onChanged: (value) {
                                  setState(() {
                                    _sensitivityValue = value;
                                    _threshold = 20 - (value * 8);
                                    print('::::_threshold $_threshold');
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
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
    AnalyticsEngine.logAlarmActivated('Do_not_touch_my_phone');
    String tunePath = TuneManager.getSelectedTune();
    // Set the device volume to maximum
    VolumeController().maxVolume();

    final player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    player.play(AssetSource(tunePath), volume: 1.0);
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

  @override
  void dispose() {
    subscription?.cancel(); // Cancel accelerometer subscription
    super.dispose();
  }
}
