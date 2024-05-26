import 'package:antitheftalarm/theme/theme_text.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:flutter/material.dart';

class AntiPocketDetection extends StatefulWidget {
  const AntiPocketDetection({super.key});

  @override
  State<AntiPocketDetection> createState() => _AntiPocketDetectionState();
}

class _AntiPocketDetectionState extends State<AntiPocketDetection> {
  bool _switchValue = false;
  bool _stopswitchValue = false;
  int _selectedIndex = 0;
  double _sensitivityValue = 0.5;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Add your navigation logic here based on the index
      // For example, navigate to different screens or show different content
    });
  }

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
                      child: Icon(
                        Icons.arrow_back,
                        color: Themecolor.white,
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
                        child: CircleAvatar(
                      backgroundColor: Themecolor.black,
                      child: Text(
                        'Activate',
                        style: Themetext.ctextstyle,
                      ),
                      maxRadius: 45,
                    )),
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
                        child: Expanded(
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
                              value: _switchValue,
                              onChanged: (value) {
                                setState(() {
                                  _switchValue = value;
                                });
                              },
                            ),
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
                            value: _stopswitchValue,
                            onChanged: (value) {
                              setState(() {
                                _stopswitchValue = value;
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
