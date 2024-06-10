import 'package:antitheftalarm/controller/remote_config_services.dart';

class AdTrackinServices {
  static int _sessionCounter = 0;
  static int _adFrequency = Config.adFrequency;
  static int _maxAdsPerSession = 0;

  static void incrementSessionCounter() {
    _sessionCounter++;
  }

  static bool shouldShowAd() {
    // Check if conditions are satisfied to show an ad
    return _sessionCounter >= _adFrequency &&
        _maxAdsPerSession <= Config.maxAdsPerSession;
  }

 

  static void incrementMaxAdsPerSession() {
    // increatemet of how many times has been shown
    _maxAdsPerSession++;
  }

  static void incrementAdFrequency() {
    // increase number of interacton
    _sessionCounter++; // Manually increase ad frequency
  }
}
