import 'dart:developer';
import 'package:antitheftalarm/controller/remote_config_services.dart';
import 'package:flutter/material.dart';
import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart'; // Import your AdCounter class

class NativeAdWidget extends StatefulWidget {
  const NativeAdWidget({Key? key}) : super(key: key);

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  void loadAd() {
    if (Config.showAds) {
      // Check if conditions are met to show ad
      _nativeAd = NativeAd(
        adUnitId: AdManager.nativeAdTestId,
        factoryId: 'adFactoryExample',
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('::: NativeAd loaded.');
            setState(() {
              _nativeAdIsLoaded = true;
            });
          },
          onAdFailedToLoad: (ad, error) {
            log('::: NativeAd failed to load: $error');
            ad.dispose();
          },
        ),
        request: const AdRequest(),
      );
      _nativeAd?.load();
     
    }
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Config.hideAds // Check if ads should be hidden
        ? SizedBox()
        : _nativeAdIsLoaded
            ? Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.red, // Border color
                    width: 3.0, // Border width
                  ),
                ),
                height: 200,
                child: AdWidget(ad: _nativeAd!),
              )
            : Container(
                margin: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.red, // Border color
                    width: 3.0, // Border width
                  ),
                ),
                height: 200,
                child: Text('Loading Ads'));
  }
}
