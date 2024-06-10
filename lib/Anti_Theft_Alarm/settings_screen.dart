import 'package:antitheftalarm/Anti_Theft_Alarm/tune_selection_screen.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
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
          ListTile(
            title: Text('Select Tune'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TuneSelectionPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
