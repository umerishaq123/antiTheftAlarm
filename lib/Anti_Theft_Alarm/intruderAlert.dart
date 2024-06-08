import 'package:antitheftalarm/Anti_Theft_Alarm/native_ad_widget.dart';
import 'package:antitheftalarm/theme/theme_text.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:flutter/material.dart';

class IntruderAlert extends StatefulWidget {
  const IntruderAlert({super.key});

  @override
  State<IntruderAlert> createState() => _IntruderAlertState();
}

class _IntruderAlertState extends State<IntruderAlert> {
  bool _switchValue = false;
  bool _stopswitchValue = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Themecolor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height * 0.35,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Themecolor.primary,
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
              height: height * 0.57,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Intruder Alert',
                        style: Themetext.atextstyle.copyWith(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      Align(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.info_outline_rounded),
                        ),
                      ),
                    ],
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
                        leading: Icon(Icons.tv),
                        title: Text(
                          'Intruder Alert',
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
                        leading: Icon(Icons.lock_clock),
                        title: Text(
                          'Stop alarm with unlock',
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
                  SizedBox(height: height * 0.01),
                  NativeAdWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
