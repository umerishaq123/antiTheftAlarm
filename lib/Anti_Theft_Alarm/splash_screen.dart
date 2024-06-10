import 'package:antitheftalarm/Anti_Theft_Alarm/homepage.dart';
import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:antitheftalarm/controller/analytics_engine.dart';
import 'package:antitheftalarm/controller/remote_config_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Delay for splash screen
    Future.delayed(Duration(seconds: 2), () {
      if (Config.showSplashAds) {
        print(':::showSplashAds ${Config.showSplashAds}');
        AdManager.showInterstitialAdOnSplash(
            onComplete: () {
              navigateToHomePage();
            },
            context: context);
      } else {
        navigateToHomePage();
      }
    });

    AnalyticsEngine.logAppOpened();
  }

  // Function to navigate to home page
  void navigateToHomePage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Homepage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Image.asset('assets/images/app_icon.png'),
        ),
      ),
    );
  }
}
