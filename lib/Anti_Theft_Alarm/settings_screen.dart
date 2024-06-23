import 'package:antitheftalarm/Anti_Theft_Alarm/tune_selection_screen.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:antitheftalarm/widgets/native_ad_widget.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Themecolor.white),
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          NativeAdWidget(),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TuneSelectionPage()),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Leading widget
                  Row(
                    children: [
                      Icon(Icons.settings),
                      // Text widget as the button label
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text('Select Tune'),
                      ),
                    ],
                  ),

                  // Trailing widget
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),

          // Container(
          //   margin: EdgeInsets.all(12),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(15),
          //       border: Border(
          //           bottom: BorderSide(width: 2.0, style: BorderStyle.solid))),
          //   child: ListTile(
          //     title: Text('Select Tune'),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => TuneSelectionPage()),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
