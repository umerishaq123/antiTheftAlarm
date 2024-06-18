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
        let channel = FlutterMethodHandler.setup(with: flutterViewController.binaryMessenger)

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}










class FlutterMethodHandler {
    static func setup(with binaryMessenger: FlutterBinaryMessenger) -> FlutterMethodChannel {
        let channel = FlutterMethodChannel(name: "dev.fluttercommunity.plus/sensors/method", binaryMessenger: binaryMessenger)
        channel.setMethodCallHandler { (call, result) in
            self.handleMethodCall(call, result: result)
        }
        return channel
    }

    private static func handleMethodCall(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "setAccelerationSamplingPeriod" {
            // Implement your logic here
            // For instance, you might want to set the sampling period for sensor data
            result(nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }
}
