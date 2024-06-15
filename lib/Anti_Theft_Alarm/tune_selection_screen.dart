import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:antitheftalarm/controller/ad_tracking_services.dart';
import 'package:antitheftalarm/controller/analytics_engine.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TuneSelectionPage extends StatefulWidget {
  @override
  _TuneSelectionPageState createState() => _TuneSelectionPageState();
}

class _TuneSelectionPageState extends State<TuneSelectionPage> {
  late AudioPlayer _audioPlayer;
  late String _selectedTune;
  List<String> tunes = [
    'alarm.mp3',
    'alarm_clock_old.mp3',
    'extreme_alarm_clock.mp3',
    'iphone_alarm.mp3',
    'wake_up.mp3',
  ];
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      AdManager.showInterstitialAd(onComplete: () {}, context: context);
    });    AnalyticsEngine.logFeatureClicked('TuneSelectionPage');
    AdTrackinServices.incrementAdFrequency();
    _audioPlayer = AudioPlayer();
    // Provide a default value for _selectedTune
    _selectedTune = '';
    _initSelectedTune(); // Initialize the selected tune from SharedPreferences
  }

  Future<void> _initSelectedTune() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTune = prefs.getString('selected_tune') ??
          (tunes.isNotEmpty ? tunes[0] : '');
    });
  }

  void _playTune(String tunePath) async {
    await _audioPlayer.play(AssetSource(tunePath)); // Play the selected tune
  }

  void _stopTune() {
    _audioPlayer.stop(); // Stop the currently playing tune
  }

  void _saveTune(String tunePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_tune', tunePath); // Save the tune
    setState(() {
      _selectedTune = tunePath;
    });
    Navigator.pop(
        context, tunePath); // Go back to settings page with selected tune
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Themecolor.white),
        title: Text('Select Tune'),
      ),
      body: ListView.builder(
        itemCount: tunes.length,
        itemBuilder: (context, index) {
          String tunePath = tunes[index];
          bool isSelected = _selectedTune == tunePath;
          return ListTile(
            title: Text(tunePath.split('/').last),
            leading: Radio(
              value: tunePath,
              groupValue: _selectedTune,
              onChanged: (String? value) {
                _saveTune(tunePath); // Save the tune
              },
            ),
            onTap: () {
              _playTune(tunePath); // Play the tune when clicked
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Tune Options'),
                    content: Text('Do you want to save this tune?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          _stopTune(); // Stop the tune
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _saveTune(tunePath); // Save the tune
                          _stopTune(); // Stop the tune
                        },
                        child: Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
