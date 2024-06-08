import 'package:antitheftalarm/Anti_Theft_Alarm/air_pods_ddetction.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/anti_pocket_detecttion.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/avoid_overcharging.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/charging_detection.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/donotTouchPhone.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/drawer.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/intruderAlert.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/wifi_detection.dart';
import 'package:antitheftalarm/controller/analytics_engine.dart';
import 'package:antitheftalarm/controller/utils.dart';
import 'package:antitheftalarm/theme/theme_text.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  bool didItShowedInterestitalAd;
  Homepage({super.key, required this.didItShowedInterestitalAd});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 10), () {
    //   print('::: calling getInterstitialAdButton 1 ');
    //   if (widget.didItShowedInterestitalAd == false) {
    //     print('::: calling getInterstitialAdButton 2  ');

    //     AdManager.getInterstitialAdButton(onAdLoaded: (as) {
    //       print('::: loaded the ad on home');
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: MyDrawer(width: width),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white), // Change the color here

        title: Text('Anti Theft Alarm'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Feature'),
              SizedBox(
                height: height * 0.01,
              ),
              InkWell(
                onTap: () {
                  // logFeatureClicked
                  // AnalyticsEngine.logFeatureClicked('Intruder Alert');
                  Utils.snackBar('Feature will be avaialble soon.', context);

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => IntruderAlert(),
                  //     ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: height * 0.13,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black,
                                  width: 2.0,
                                  style: BorderStyle.solid))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Intruder Alert',
                                  style: Themetext.atextstyle.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                Icon(
                                  Icons.warning_amber,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Capture intruder photos upon unatherrised unlock attempt',
                            style: Themetext.greyColortextstyle,
                          )
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              InkWell(
                onTap: () {
                  AnalyticsEngine.logFeatureClicked('Do_not_touch_my_phone');

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DonotTouchPhone(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: height * 0.13,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                              bottom: BorderSide(
                                  width: 2.0, style: BorderStyle.solid))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Donot Touch My Phone',
                                  style: Themetext.atextstyle.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                Icon(
                                  Icons.mobile_off_rounded,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Detect When your phone is moved',
                              style: Themetext.greyColortextstyle,
                            ),
                          )
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              InkWell(
                onTap: () {
                  // AnalyticsEngine.logFeatureClicked('Anti_Pocket_Detection');
                  Utils.snackBar('Feature will be available soon', context);
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => AntiPocketDetection(),
                  //     ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: height * 0.13,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                              bottom: BorderSide(
                                  width: 2.0, style: BorderStyle.solid))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Anti Pocket Detection',
                                  style: Themetext.atextstyle.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                Icon(
                                  Icons.not_accessible_sharp,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Detect when remove from pocket',
                              style: Themetext.greyColortextstyle,
                            ),
                          )
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              InkWell(
                onTap: () {
                  AnalyticsEngine.logFeatureClicked('Charging_detection');

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChargingDetection(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: height * 0.13,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                              bottom: BorderSide(
                                  width: 2.0, style: BorderStyle.solid))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Charging Detection',
                                  style: Themetext.atextstyle.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                Icon(
                                  Icons.charging_station_outlined,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Detect when charge is unplugged',
                              style: Themetext.greyColortextstyle,
                            ),
                          )
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              InkWell(
                onTap: () {
                  AnalyticsEngine.logFeatureClicked('Wifi_detection');

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WifiDetection(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: height * 0.13,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                              bottom: BorderSide(
                                  width: 2.0, style: BorderStyle.solid))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Wifi Detection',
                                  style: Themetext.atextstyle.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                Icon(
                                  Icons.wifi,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Alarm when someone try to on/off the wifi',
                              style: Themetext.greyColortextstyle,
                            ),
                          )
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              InkWell(
                onTap: () {
                  AnalyticsEngine.logFeatureClicked('Avoid_over_charging');

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AvoidOvercharging(),
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: height * 0.13,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                              bottom: BorderSide(
                                  width: 2.0, style: BorderStyle.solid))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Avoid Overcharging',
                                  style: Themetext.atextstyle.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                Icon(
                                  Icons.charging_station_rounded,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Alarm when battry is fully charged!',
                              style: Themetext.greyColortextstyle,
                            ),
                          )
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              InkWell(
                onTap: () {
                  Utils.snackBar('Feature will be avaialble soon.', context);
                  // AnalyticsEngine.logFeatureClicked('BluetoothConnectionStatus');
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => BluetoothConnectionStatus(),
                  //     ));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: height * 0.13,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border(
                              bottom: BorderSide(
                                  width: 2.0, style: BorderStyle.solid))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'AirPhones Detection',
                                  style: Themetext.atextstyle.copyWith(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16),
                                ),
                                Icon(
                                  Icons.headphones,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Alarm when battery is fully charged!',
                              style: Themetext.greyColortextstyle,
                            ),
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
