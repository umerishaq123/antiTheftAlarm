import 'dart:async';
import 'package:antitheftalarm/Anti_Theft_Alarm/native_ad_widget.dart';
import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:antitheftalarm/controller/ad_tracking_services.dart';
import 'package:antitheftalarm/controller/analytics_engine.dart';
import 'package:antitheftalarm/controller/tune_manager.dart';
import 'package:antitheftalarm/theme/theme_text.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:torch_light/torch_light.dart';
import 'package:vibration/vibration.dart';
import 'package:volume_controller/volume_controller.dart';

class WifiDetection extends StatefulWidget {
  const WifiDetection({super.key});

  @override
  State<WifiDetection> createState() => _WifiDetectionState();
}

class _WifiDetectionState extends State<WifiDetection> {
  List<ConnectivityResult> _connectionStatus = [ConnectivityResult.none];
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  bool isActivatedPress = false;
  bool _tourch = false;
  bool vibration = false;
  bool isAlarmTriigered = false;

  @override
  void initState() {
    super.initState();
    AdManager.showInterstitialAd(onComplete: () {}, context: context);
    AdTrackinServices.incrementAdFrequency();
    AnalyticsEngine.logFeatureClicked('Wifi_detection');
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late List<ConnectivityResult> result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('::::Couldn\'t check connectivity status $e');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    setState(() {
      _connectionStatus = result;
    });
    // ignore: avoid_print
    print('::: Connectivity changed: $_connectionStatus');
    if (!result.contains(ConnectivityResult.wifi)) {
      print(":::Disconnected from WiFi, start alarm!");
      // Add your alarm triggering logic here
      // For example, you can call a function to start the alarm
      if (isAlarmTriigered == false) {
        isAlarmTriigered = true;
        _playSound(context, _tourch, vibration);
      }
    } else {
      print("Connected to WiFi");
    }
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          color: Themecolor.white,
          child: Column(
            children: [
              Container(
                  height: height * 0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Themecolor.primary,
                  ),
                  child: NativeAdWidget()),
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
                        'Wifi Detection',
                        style: Themetext.atextstyle.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    InkWell(
                      onTap: () async {
                        // Check connectivity
                        List<ConnectivityResult> connectivityResult =
                            await _connectivity.checkConnectivity();
                        if (!connectivityResult
                            .contains(ConnectivityResult.wifi)) {
                          // If not connected to WiFi, show Snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'In order to start the alarm please connect to WiFi first!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } else {
                          // if(_connectivity == ){}
                          if (isAlarmTriigered == true) {
                            isAlarmTriigered = false;
                          }
                          {
                            setState(() {
                              isActivatedPress = true;
                            });
                            initConnectivity();

                            _connectivitySubscription = _connectivity
                                .onConnectivityChanged
                                .listen(_updateConnectionStatus);
                          }
                        }
                      },
                      child: Center(
                          child: CircleAvatar(
                        backgroundColor: Themecolor.black,
                        child: Text(
                          isActivatedPress ? 'Activated' : 'Activate',
                          style: Themetext.ctextstyle,
                        ),
                        maxRadius: 45,
                      )),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Tap to Activate',
                      style: Themetext.atextstyle
                          .copyWith(fontWeight: FontWeight.bold),
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
                            value: _tourch,
                            onChanged: (value) {
                              setState(() {
                                _tourch = value;
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
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.settings),
      //       label: 'Settings',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Themecolor.primary,
      //   onTap: _onItemTapped,
      // ),
    );
  }

  _playSound(BuildContext context, bool torch, bool vibrate) async {
    String tunePath = TuneManager.getSelectedTune();
    AnalyticsEngine.logAlarmActivated('Wifi_detection');

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
