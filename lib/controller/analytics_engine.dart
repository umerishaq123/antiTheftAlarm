import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsEngine {
  static final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Log an event when a specific feature is clicked
  static Future<void> logFeatureClicked(String featureName) async {
    _analytics.logEvent(
      name: 'feature_clicked',
      parameters: {'feature_name': featureName},
    );
  }

  // Log an event when the app is opened
  static Future<void> logAppOpened() async {

    _analytics.logEvent(name: 'splash_screen');
  }

  // Log an event when a specific alarm is activated
  static Future<void> logAlarmActivated(String alarmName) async {
    print('::: logAlarmActivated $logAlarmActivated');
    _analytics.logEvent(
      name: 'alarm_activated',
      parameters: {'alarm_name': alarmName},
    );
  }

  // // Log an event when a user views a specific screen
  // static Future<void> logScreenView(String screenName) async {
  //   _analytics.logEvent(
  //     name: 'screen_view',
  //     parameters: {'screen_name': screenName},
  //   );
  // }
}
