import 'dart:developer';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:flutter/material.dart';
import 'package:antitheftalarm/controller/remote_config_services.dart';
import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NativeAdWidget extends StatefulWidget {
  // final bool isSmallTemplete;
  const NativeAdWidget({Key? key})
      : super(key: key);

  @override
  State<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;
  bool _adFailedToLoad = false;

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  void loadAd() {
    if (Config.showAds) {
      _nativeAd = NativeAd(
        adUnitId: AdManager.nativeAdRealId,
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
            setState(() {
              _adFailedToLoad = true;
            });
          },
        ),
        request: const AdRequest(),
        nativeTemplateStyle: NativeTemplateStyle(
          templateType:
               TemplateType.small,
          // Customize ad styles here
          // mainBackgroundColor: Colors.purple,
          cornerRadius: 10.0,
          callToActionTextStyle: NativeTemplateTextStyle(
            textColor: Themecolor.white,
            backgroundColor: Themecolor.primary,
            style: NativeTemplateFontStyle.monospace,
            size: 16.0,
          ),
          primaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.black,
            // backgroundColor: Colors.cyan,
            style: NativeTemplateFontStyle.italic,
            size: 16.0,
          ),
          secondaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.green,
            backgroundColor: Colors.black,
            style: NativeTemplateFontStyle.bold,
            size: 16.0,
          ),
          tertiaryTextStyle: NativeTemplateTextStyle(
            textColor: Colors.brown,
            backgroundColor: Colors.amber,
            style: NativeTemplateFontStyle.normal,
            size: 16.0,
          ),
        ),
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
    if (!Config.showAds) {
      // Ads are hidden, return an empty SizedBox
      return SizedBox();
    }

    if (_adFailedToLoad) {
      // Show a default container if ad fails to load
      return Container(
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.red,
            width: 1.0,
          ),
        ),
        height: 200,
        child: Center(
          child: Text('Failed to load ad'),
        ),
      );
    }

    // Default state: show loading container while ad is being loaded
    return ConstrainedBox(
      constraints:
          BoxConstraints(
              minWidth: MediaQuery.of(context)
                  .size
                  .width, // minimum recommended width
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height / 6,
            ),
         
      child: _nativeAdIsLoaded
          ? Container(
              margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                // border: Border.all(
                //   color: Colors.green,
                //   width: 1.0,
                // ),
              ),
              child: AdWidget(ad: _nativeAd!))
          : Center(
              child: Container(
                padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  width: double.infinity,
                  height:  MediaQuery.of(context).size.height / 6,
                    
                  child: Text('Loading Ad...'))),
    );
  }
}
