import 'dart:developer';

import 'package:firebase_remote_config/firebase_remote_config.dart';

class Config {
  static final _config = FirebaseRemoteConfig.instance;

  static const _defaultValues = {
    "show_ads": true,
    "ad_frequency": 3, // Adjusted for session-based frequency
    "max_ads_per_session": 3, // Adjusted for session-based maximum ads
  };

  static Future<void> initConfig() async {
    await _config.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 30)));

    await _config.setDefaults(_defaultValues);
    await _config.fetchAndActivate();
    log(':::Remote Config Data: ${_config.getBool('show_ads')}');

    _config.onConfigUpdated.listen((event) async {
      await _config.activate();
      log(':::Updated: ${_config.getBool('show_ads')}');
    });
  }

  static bool get _showAdprivate => _config.getBool('show_ads');

  static bool get showAds => _config.getBool('show_ads');
  static bool get showSplashAds => _config.getBool('show_splash_ad');
  static int get adFrequency => _config.getInt('ad_frequency');
  static int get maxAdsPerSession => _config.getInt('max_ads_per_session');
  static bool get hideAds => !_showAdprivate;
}

class AdCounter {
  static int _sessionCounter = 0;
  static int _adFrequency = Config.adFrequency;
  static int _maxAdsPerSession = 0; // Initially set to 0

  static void incrementSessionCounter() {
    _sessionCounter++;
    if (_sessionCounter >= _adFrequency) {
      _adFrequency++; // Increase ad frequency after an ad is shown
      _sessionCounter = 0; // Reset session counter
    }
  }

  static bool shouldShowAd() {
    return _sessionCounter >= _adFrequency &&
        _maxAdsPerSession < Config.maxAdsPerSession;
  }

  static void incrementMaxAdsPerSession() {
    _maxAdsPerSession++;
  }
}
