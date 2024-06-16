import UIKit
import Flutter
import GoogleMobileAds

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "dev.fluttercommunity.plus/sensors/method", binaryMessenger: flutterViewController.binaryMessenger)
        channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "setAccelerationSamplingPeriod" {
                // Implement your logic here
                // For instance, you might want to set the sampling period for sensor data
                result(nil)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        GeneratedPluginRegistrant.register(with: self) 
        GADMobileAds.sharedInstance().start(completionHandler: nil)

        weak var registrar = self.registrar(forPlugin:"my-views")
        let adViewFactory = MyAdViewNativeViewFactory(messenger : registrar!.messenger())
        let viewRegistrar = self.registrar(forPlugin: "<my-views>")!
        viewRegistrar.register(
          adViewFactory,
          withId : "myNativeAdView")


        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
