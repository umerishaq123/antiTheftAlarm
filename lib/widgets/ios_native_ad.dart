import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const myNativeAdView = 'myNativeAdView';

class IosNativeScreen extends StatelessWidget {
  const IosNativeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const UiKitView(
      viewType: myNativeAdView,
      layoutDirection: TextDirection.ltr,
      creationParams: null,
      creationParamsCodec: StandardMessageCodec(),
    );
  }
}
