import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:antitheftalarm/controller/ad_tracking_services.dart';
import 'package:antitheftalarm/controller/analytics_engine.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:antitheftalarm/widgets/native_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class TuneSelectionPage extends StatefulWidget {
  @override
  _TuneSelectionPageState createState() => _TuneSelectionPageState();
}

class _TuneSelectionPageState extends State<TuneSelectionPage> {
  late AudioPlayer _audioPlayer;
  late String _selectedTune;
  late String _currentlyPlayingTune;
  bool isPlaying = false;
  double progress = 0.0;
  String currentPosition = "0:00";
  String totalDuration = "0:00";
  Timer? _timer;

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
    _audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) {
        setState(() {
          totalDuration = _formatDuration(duration);
        });
      }
    });
    _audioPlayer.onPositionChanged.listen((position) {
      if (mounted) {
        setState(() {
          currentPosition = _formatDuration(position);
          _audioPlayer.getDuration().then((duration) {
            if (duration != null && mounted) {
              setState(() {
                progress = position.inSeconds / duration.inSeconds;
              });
            }
          });
        });
      }
    });
  }

  Future<void> _initSelectedTune() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _selectedTune = prefs.getString('selected_tune') ?? (tunes.isNotEmpty ? tunes[0] : '');
      });
    }
  }

  void _playTune(String tunePath) async {
    if (_currentlyPlayingTune == tunePath && isPlaying) {
      _stopTune();
    } else {
      await _audioPlayer.play(AssetSource(tunePath));
      if (mounted) {
        setState(() {
          _currentlyPlayingTune = tunePath;
          isPlaying = true;
          progress = 0.0;
          currentPosition = "0:00";
        });
      }
    }
  }

  void _stopTune() {
    _audioPlayer.stop();
    if (mounted) {
      setState(() {
        isPlaying = false;
        _timer?.cancel();
      });
    }
  }

  void _saveTune(String tunePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_tune', tunePath);
    if (mounted) {
      setState(() {
        _selectedTune = tunePath;
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inMinutes)}:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Themecolor.white),
        title: Text('Select Tune', style: TextStyle(color: Themecolor.white)),
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
                bool isPlayingTune = _currentlyPlayingTune == tunePath && isPlaying;

                return Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Themecolor.primary : Colors.grey,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        title: Text(tunePath.split('/').last),
                                                        titleTextStyle: TextStyle(fontSize: 12, color: Colors.black),

                        leading: IconButton(
                          icon: Icon(isPlayingTune ? Icons.pause : Icons.play_arrow),
                          onPressed: () {
                            _playTune(tunePath);
                          },
                        ),
                        trailing: isSelected ? Icon(Icons.check, color: Themecolor.primary ) : null,
                        onTap: () {
                          _saveTune(tunePath);
                        },
                        subtitle: isPlayingTune
                            ? Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: VideoProgressBar(
                                  isPlaying: isPlaying,
                                  progress: progress,
                                  currentPosition: currentPosition,
                                  totalDuration: totalDuration,
                                  onPlayPause: () {
                                    if (mounted) {
                                      setState(() {
                                        isPlaying = !isPlaying;
                                        if (isPlaying) {
                                          _audioPlayer.resume();
                                        } else {
                                          _audioPlayer.pause();
                                        }
                                      });
                                    }
                                  },
                                ),
                              )
                            : SizedBox(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class VideoProgressBar extends StatelessWidget {
  final bool isPlaying;
  final double progress;
  final String currentPosition;
  final String totalDuration;
  final VoidCallback onPlayPause;

  const VideoProgressBar({
    Key? key,
    required this.isPlaying,
    required this.progress,
    required this.currentPosition,
    required this.totalDuration,
    required this.onPlayPause,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          currentPosition,
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: LinearProgressIndicator(
            value: progress,
            valueColor: const AlwaysStoppedAnimation(Colors.black),
            backgroundColor: Colors.black26,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          totalDuration,
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }
}
