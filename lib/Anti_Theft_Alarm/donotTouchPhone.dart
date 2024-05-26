import 'dart:async';
import 'dart:math';

import 'package:antitheftalarm/controller.dart';
import 'package:antitheftalarm/theme/theme_text.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class DonotTouchPhone extends StatefulWidget {
  const DonotTouchPhone({super.key});

  @override
  State<DonotTouchPhone> createState() => _DonotTouchPhoneState();
}

class _DonotTouchPhoneState extends State<DonotTouchPhone> {
  bool _flashlight = false;
  bool vibration = false;
  int _selectedIndex = 0;
  double _sensitivityValue = 0.5;
  double _threshold = 12.0; // Adjust the threshold for sensitivity
  StreamSubscription<AccelerometerEvent>? _subscription;
  bool _isAlarming = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add your navigation logic here based on the index
      // For example, navigate to different screens or show different content
    });
  }

  @override
  void initState() {
    super.initState();
  }

  bool isAlarmTriigered = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  // borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 55, left: 15),
                        child: Icon(
                          Icons.arrow_back,
                          color: Themecolor.white,
                        ),
                      ),
                    ),
                  ],
                ),
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
                        if (isAlarmTriigered == false) {
                          setState(() {
                            isAlarmTriigered = true;
                          });
                          // playSound(context, true, true);
                        }
                        _subscription = accelerometerEvents
                            .listen((AccelerometerEvent event) {
                          double totalAcceleration = sqrt(event.x * event.x +
                              event.y * event.y +
                              event.z * event.z);
                          if (totalAcceleration > _threshold && !_isAlarming) {
                            playSound(context, _flashlight, vibration);
                          }
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Themecolor.black,
                        child: Text(
                          'Activate',
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
                            'motion Alarm Sensitivity',
                            style: Themetext.atextstyle,
                          ),
                          subtitle: Column(
                            children: [
                              Text(
                                'please adjust  sensitivity for motion detection ',
                                style: Themetext.greyColortextstyle,
                              ),
                              Slider(
                                value: _sensitivityValue,
                                min: 0,
                                max: 1,
                                divisions: 10,
                                label: (_sensitivityValue * 100)
                                    .round()
                                    .toString(),
                                onChanged: (value) {
                                  setState(() {
                                    _sensitivityValue = value;
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Themecolor.primary,
        onTap: _onItemTapped,
      ),
    );
  }
}
