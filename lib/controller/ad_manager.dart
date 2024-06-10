import 'dart:developer';
import 'dart:io';

import 'package:antitheftalarm/controller/ad_tracking_services.dart';
import 'package:antitheftalarm/controller/remote_config_services.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static var nativeAdTestId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';

  static var nativeAdRealId = 'ca-app-pub-4161728863134324/8496591945';

  static var interstitialAdRealId = 'ca-app-pub-4161728863134324/2286406818';
  static var interstitialAdTestId = "ca-app-pub-7319269804560504/6941421099";

  // for initializing ads sdk
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await MobileAds.instance.initialize();
  }

  static InterstitialAd? _interstitialAd;
  static bool _interstitialAdLoaded = false;

  static void showInterstitialAdOnSplash(
      {required VoidCallback onComplete, required BuildContext context}) {
    log('::: showInterstitialAdOnSplash');

    if (Config.showAds) {
      if (_interstitialAdLoaded && _interstitialAd != null) {
        _interstitialAd?.show();
        onComplete();
        return;
      }

      MyDialogs.showProgress(context);

      InterstitialAd.load(
        adUnitId: interstitialAdTestId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            //ad listener
            ad.fullScreenContentCallback =
                FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              onComplete();
            });
            // Get.back();
            Navigator.pop(context);
            ad.show();
           
          },
          onAdFailedToLoad: (err) {
            Navigator.pop(context);
            log(':::Failed to load an showInterstitialAdOnSplash ad: ${err.message}');
            onComplete();
          },
        ),
      );
    } else {
      onComplete();
    }
  }

  static void showInterstitialAd(
      {required VoidCallback onComplete, required BuildContext context}) {
    log('::: trying to showInterstitialAd}');
    if (Config.showAds == true && AdTrackinServices.shouldShowAd()) {
      if (_interstitialAdLoaded && _interstitialAd != null) {
        _interstitialAd?.show();
        onComplete();
        return;
      }

      MyDialogs.showProgress(context);

      InterstitialAd.load(
        adUnitId: interstitialAdTestId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            //ad listener
            ad.fullScreenContentCallback =
                FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
              onComplete();
            });
            // Get.back();
            Navigator.pop(context);
            ad.show();
            AdTrackinServices
                .incrementMaxAdsPerSession(); // Increment max ads per session
            log(':::onAdLoaded InterstitialAd');
          },
          onAdFailedToLoad: (err) {
            Navigator.pop(context);
            log(':::Failed to load an interstitial ad: ${err.message}');
            onComplete();
          },
        ),
      );
    } else {
      onComplete();
      log('::: Config.showAds is ${Config.showAds}}');
      log('::: AdTrackinServices.shouldShowAd() is ${AdTrackinServices.shouldShowAd()}}');
    }
  }

  // static void loadInterstitialAd({
  //   required Function(InterstitialAd ad) onAdLoaded,
  //   required Null Function(dynamic error) onAdFailedToLoad,
  // }) {
  //   InterstitialAd.load(
  //     adUnitId: interstitialAdTestId,
  //     request: AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (ad) {
  //         onAdLoaded(ad);
  //       },
  //       onAdFailedToLoad: (error) {
  //         print(':::InterstitialAd failed to load: $error');
  //       },
  //     ),
  //   );
  // }

  // static void showInterstitialAd(InterstitialAd ad) {
  //   ad.show();
  // }
}

class MyDialogs {
  static void showProgress(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        );
      },
    );
  }
}
