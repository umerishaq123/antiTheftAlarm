import 'package:antitheftalarm/Anti_Theft_Alarm/homepage.dart';
import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:antitheftalarm/controller/analytics_engine.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    // Initialize Google AdMob
    // AdManager.init();
    // Load interstitial ad
    AdManager.loadInterstitialAd(
      onAdLoaded: (ad) {
        setState(() {
          _interstitialAd = ad;
        });
      },
    );
    // Delay for splash screen
    Future.delayed(Duration(seconds: 2), () {
      // Check if interstitial ad is loaded
      if (_interstitialAd != null) {
        // Show interstitial ad
        _interstitialAd!.show();

        // Add a listener to know when the interstitial ad is closed
        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdDismissedFullScreenContent: (InterstitialAd ad) {
            // Proceed to home page after ad is closed
            navigateToHomePage(true);
          },
        );
      } else {
        // Proceed without showing ad
        // Replace `HomeScreen()` with the screen you want to navigate to after splash
        navigateToHomePage(false);
      }
    });
    AnalyticsEngine.logAppOpened();
  }

  // Function to navigate to home page
  void navigateToHomePage(bool didit) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => Homepage(
                didItShowedInterestitalAd: didit,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child:Image.asset('assets/images/app_icon.png'),
        ),
      ),
    );
  }
}
