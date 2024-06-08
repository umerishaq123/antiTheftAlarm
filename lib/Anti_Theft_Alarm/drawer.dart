import 'package:antitheftalarm/Anti_Theft_Alarm/anti_pocket_detecttion.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/avoid_overcharging.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/charging_detection.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/donotTouchPhone.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/intruderAlert.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/rating_dialoge.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/wifi_detection.dart';
import 'package:antitheftalarm/controller/analytics_engine.dart';
import 'package:antitheftalarm/controller/utils.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
    required this.width,
  });

  final double width;
  void shareApp() {
    final String appLink =
        'https://play.google.com/store/apps/details?id=com.ginnie.dont.touch.phone.antitheft';
    Share.share('Check out this amazing app: $appLink');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Drawer(
      width: width,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel_outlined))
            ],
          ),
          Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Features',
                style: TextStyle(fontSize: 20),
              )),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.pop(context);
                // AnalyticsEngine.logFeatureClicked('Intruder Alert');
                Utils.snackBar('Feature will be avaialble soon.', context);

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => IntruderAlert(),
                //     ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading widget
                  Row(
                    children: [
                      Icon(Icons.warning_amber),
                      // Text widget as the button label
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('Intruder alert'),
                      ),
                    ],
                  ),

                  // Trailing widget
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                AnalyticsEngine.logFeatureClicked('Do_not_touch_my_phone');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonotTouchPhone(),
                    ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading widget
                  Row(
                    children: [
                      Icon(Icons.mobile_off_rounded),
                      // Text widget as the button label
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('Dont touch my phone'),
                      ),
                    ],
                  ),

                  // Trailing widget
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.pop(context);
                // AnalyticsEngine.logFeatureClicked('Anti_Pocket_Detection');
                Utils.snackBar('Feature will be available soon', context);
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => AntiPocketDetection(),
                //     ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading widget
                  Row(
                    children: [
                      Icon(Icons.not_accessible_sharp),
                      // Text widget as the button label
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('Anti pocket detection'),
                      ),
                    ],
                  ),

                  // Trailing widget
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                AnalyticsEngine.logFeatureClicked('Charging_detection');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChargingDetection(),
                    ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading widget
                  Row(
                    children: [
                      Icon(Icons.battery_charging_full),
                      // Text widget as the button label
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('Charging Detection'),
                      ),
                    ],
                  ),

                  // Trailing widget
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                AnalyticsEngine.logFeatureClicked('Wifi_detection');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WifiDetection(),
                    ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading widget
                  Row(
                    children: [
                      Icon(Icons.wifi_lock_sharp),
                      // Text widget as the button label
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('Wifi detection'),
                      ),
                    ],
                  ),

                  // Trailing widget
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                AnalyticsEngine.logFeatureClicked('Avoid_over_charging');

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AvoidOvercharging(),
                    ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading widget
                  Row(
                    children: [
                      Icon(Icons.battery_unknown_rounded),
                      // Text widget as the button label
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('Avoid over charging'),
                      ),
                    ],
                  ),

                  // Trailing widget
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Utils.snackBar('Feature will be avaialble soon.', context);
                // AnalyticsEngine.logFeatureClicked('BluetoothConnectionStatus');
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => BluetoothConnectionStatus(),
                //     ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading widget
                  Row(
                    children: [
                      Icon(Icons.headphones),
                      // Text widget as the button label
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('Air Phones detection'),
                      ),
                    ],
                  ),

                  // Trailing widget
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Others',
                style: TextStyle(fontSize: 20),
              )),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                shareApp();
                // Navigator.pop(context);
                // print('::: i am pressign share');
                // Share.share('check out my website https://example.com', subject: 'Look what I made!');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading widget
                  Row(
                    children: [
                      Icon(Icons.share),
                      // Text widget as the button label
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('Share'),
                      ),
                    ],
                  ),

                  // Trailing widget
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                showRatingDialog(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading widget
                  Row(
                    children: [
                      Icon(Icons.star_rate),
                      // Text widget as the button label
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('Rate App'),
                      ),
                    ],
                  ),

                  // Trailing widget
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading widget
                  Row(
                    children: [
                      Icon(Icons.privacy_tip_outlined),
                      // Text widget as the button label
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('Privacy Policy'),
                      ),
                    ],
                  ),

                  // Trailing widget
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading widget
                  Row(
                    children: [
                      Icon(Icons.dashboard),
                      // Text widget as the button label
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('More Apps'),
                      ),
                    ],
                  ),

                  // Trailing widget
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
