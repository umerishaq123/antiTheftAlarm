import 'dart:async';

import 'package:antitheftalarm/controller.dart';
import 'package:antitheftalarm/theme/theme_text.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/material.dart';

class AvoidOvercharging extends StatefulWidget {
  const AvoidOvercharging({super.key});

  @override
  State<AvoidOvercharging> createState() => _AvoidOverchargingState();
}

class _AvoidOverchargingState extends State<AvoidOvercharging> {
  bool flashlight = false;
  bool vibrate = false;
  int _selectedIndex = 0;
  double _sensitivityValue = 0.5;
  final Battery _battery = Battery();

  StreamSubscription<BatteryState>? _batterySubscription;
  bool _isAlarming = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add your navigation logic here based on the index
      // For example, navigate to different screens or show different content
    });
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
                    Padding(
                      padding: const EdgeInsets.only(top: 55, left: 15),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
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
                        'Avoid Over charging',
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
                            _batterySubscription = _battery.onBatteryStateChanged.listen((BatteryState state) async {
                              print('Battery state changed: $state'); // Debug statement
                              if (state == BatteryState.full && !_isAlarming) {
                                print('Battery is full. Playing sound...'); // Debug statement
                                _isAlarming = true;
                                playSound(context, flashlight, vibrate);
                              }
                            });
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
                    )),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(
                      'Please connect charger',
                      style: Themetext.atextstyle
                          .copyWith(fontWeight: FontWeight.bold),
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
                            value: flashlight,
                            onChanged: (value) {
                              setState(() {
                                flashlight = value;
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
                            value: vibrate,
                            onChanged: (value) {
                              setState(() {
                                vibrate = value;
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
                        // height: height * 0.1,
                        decoration: BoxDecoration(
                            color: Colors.green[300],
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Image.asset('assets/images/charger.jpg'),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Avoid Over charging',
                                  style: Themetext.atextstyle.copyWith(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                'For the best result always turn on vibration when you are in crowded areas and also turn on the flash light',
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
