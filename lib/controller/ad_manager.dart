import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  static var nativeAdTestId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/2247696110'
      : 'ca-app-pub-3940256099942544/3986624511';

  static var nativeAdRealId = 'ca-app-pub-4161728863134324/8496591945';

  static var interstitialAdRealId = 'ca-app-pub-4161728863134324/2286406818';
  static var interstitialAdTestId = "ca-app-pub-7319269804560504/6941421099";

  static void init() {
    WidgetsFlutterBinding.ensureInitialized();
    MobileAds.instance.initialize();
  }

  static void loadInterstitialAd({
    // required String adUnitId,
    required Function(InterstitialAd ad) onAdLoaded,
  }) {
    InterstitialAd.load(
      adUnitId: interstitialAdTestId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          onAdLoaded(ad);
        },
        onAdFailedToLoad: (error) {
          print(':::InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  static void showInterstitialAd(InterstitialAd ad) {
    ad.show();
  }

  static getInterstitialAdAgain({
    // required String adUnitId,
    required Function(InterstitialAd ad) onAdLoaded,
  }) {
    loadInterstitialAd(onAdLoaded: onAdLoaded);
  }

  static Widget getBannerAd({required String adUnitId}) {
    return AdWidget(
      ad: BannerAd(
        adUnitId: adUnitId,
        request: AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(),
      )..load(),
    );
  }
}
