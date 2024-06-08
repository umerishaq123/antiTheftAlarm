package com.example.antitheftalarm

import android.view.LayoutInflater
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.RatingBar
import android.widget.TextView
import com.google.android.gms.ads.nativead.NativeAd
import com.google.android.gms.ads.nativead.NativeAdView
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin.NativeAdFactory

class MainActivity: FlutterActivity() {
    private val CHANNEL = "dev.fluttercommunity.plus/sensors/method"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Registering MethodChannel for sensor data
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setAccelerationSamplingPeriod") {
                // Implement your logic here
                // For instance, you might want to set the sampling period for sensor data
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
        
        // Registering NativeAdFactory for Google Mobile Ads
        flutterEngine.plugins.add(GoogleMobileAdsPlugin())
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine,
            "adFactoryExample",
            NativeAdFactoryExample(layoutInflater)
        )
    }

    override fun cleanUpFlutterEngine(flutterEngine: FlutterEngine) {
        GoogleMobileAdsPlugin.unregisterNativeAdFactory(flutterEngine, "adFactoryExample")
    }

    class NativeAdFactoryExample(private val layoutInflater: LayoutInflater) : NativeAdFactory {
        override fun createNativeAd(nativeAd: NativeAd?, customOptions: MutableMap<String, Any>?): NativeAdView {
            val adView = layoutInflater.inflate(R.layout.my_native_ad, null) as NativeAdView

            // Set the media view.
            adView.mediaView = adView.findViewById(R.id.ad_media)

            // Set other ad assets.
            adView.headlineView = adView.findViewById(R.id.ad_headline)
            adView.bodyView = adView.findViewById(R.id.ad_body)
            adView.callToActionView = adView.findViewById(R.id.ad_call_to_action)
            adView.iconView = adView.findViewById(R.id.ad_app_icon)
            adView.priceView = adView.findViewById(R.id.ad_price)
            adView.starRatingView = adView.findViewById(R.id.ad_stars)
            adView.storeView = adView.findViewById(R.id.ad_store)
            adView.advertiserView = adView.findViewById(R.id.ad_advertiser)

            // The headline and mediaContent are guaranteed to be in every NativeAd.
            (adView.headlineView as TextView).text = nativeAd?.headline
            adView.mediaView?.mediaContent = nativeAd?.mediaContent

            // These assets aren't guaranteed to be in every NativeAd, so it's important to
            // check before trying to display them.
            if (nativeAd?.body == null) {
                adView.bodyView?.visibility = View.INVISIBLE
            } else {
                adView.bodyView?.visibility = View.VISIBLE
                (adView.bodyView as TextView).text = nativeAd.body
            }

            // Similar implementation for other assets...

            // This method tells the Google Mobile Ads SDK that you have finished populating your
            // native ad view with this native ad.
            if (nativeAd != null) {
                adView.setNativeAd(nativeAd)
            }

            return adView
        }
    }
}
