import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:antitheftalarm/controller/ad_tracking_services.dart';
import 'package:antitheftalarm/controller/analytics_engine.dart';
import 'package:antitheftalarm/controller/utils.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:antitheftalarm/widgets/native_ad_widget.dart';
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
  late String _currentlyPlayingTune;
  bool isPlaying = false;

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
    });
    AnalyticsEngine.logFeatureClicked('TuneSelectionPage');
    AdTrackinServices.incrementAdFrequency();
    _audioPlayer = AudioPlayer();
    _selectedTune = '';
    _currentlyPlayingTune = '';
    _initSelectedTune();
  }

  Future<void> _initSelectedTune() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedTune = prefs.getString('selected_tune') ??
          (tunes.isNotEmpty ? tunes[0] : '');
    });
  }

  void _playTune(String tunePath) async {
    if (_currentlyPlayingTune == tunePath && isPlaying) {
      _stopTune();
    } else {
      await _audioPlayer.play(AssetSource(tunePath));
      setState(() {
        _currentlyPlayingTune = tunePath;
        isPlaying = true;
      });
    }
  }

  void _stopTune() {
    _audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _audioPlayer.dispose();
  }

  void _saveTune(String tunePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_tune', tunePath);
    setState(() {
      _selectedTune = tunePath;
    });
    // Navigator.pop(context, tunePath);
    Utils.snackBar('Saved', context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Themecolor.white),
        title: Text('Select Tune'),
      ),
      body: Column(
        children: [
          NativeAdWidget(),
          Expanded(
            child: ListView.builder(
              itemCount: tunes.length,
              itemBuilder: (context, index) {
                String tunePath = tunes[index];
                bool isSelected = _selectedTune == tunePath;
                bool isPlayingTune =
                    _currentlyPlayingTune == tunePath && isPlaying;

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected
                          ? Themecolor.primary
                          : Colors.grey, // Border color based on selection
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                  ),
                  child: ListTile(
                    subtitle: Text(tunePath.split('/').last),
                    leading: IconButton(
                      icon:
                          Icon(isPlayingTune ? Icons.pause : Icons.play_arrow),
                      onPressed: () {
                        _playTune(tunePath);
                      },
                    ),
                    trailing: isSelected
                        ? Icon(Icons.check, color: Themecolor.primary)
                        : null,
                    onTap: () {
                      _saveTune(tunePath);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
