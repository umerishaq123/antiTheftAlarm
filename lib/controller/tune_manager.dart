import 'package:shared_preferences/shared_preferences.dart';

class TuneManager {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static String getSelectedTune() {
    // Retrieve the selected tune from shared preferences
    final selectedTune = _prefs.getString('selected_tune');

    // Return the selected tune if available, otherwise return the default tune
    return selectedTune ?? 'alarm.mp3';
  }

  static Future<void> setSelectedTune(String tunePath) async {
    // Save the selected tune path to shared preferences
    await _prefs.setString('selected_tune', tunePath);
  }
}


// String tunePath = TuneManager.getSelectedTune();
// await TuneManager.setSelectedTune('assets/audio/another_audio.mp3');

