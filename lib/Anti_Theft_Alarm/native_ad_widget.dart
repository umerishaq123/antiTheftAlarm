import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdWidget extends StatefulWidget {
  const NativeAdWidget({Key? key}) : super(key: key);

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  late NativeAd _nativeAd;
  bool _nativeAdIsLoaded = false;

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  void loadAd() {
    _nativeAd = NativeAd(
      adUnitId: AdManager.nativeAdTestId,
      factoryId: 'adFactoryExample',
      listener: NativeAdListener(
        onAdLoaded: (ad) {
          print('NativeAd loaded.');
          setState(() {
            _nativeAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print('NativeAd failed to load: $error');
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    _nativeAd.load();
  }

  @override
  void dispose() {
    _nativeAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _nativeAdIsLoaded
        ? Container(
            height: 200,
            child: AdWidget(ad: _nativeAd),
          )
        : SizedBox();
  }
}
