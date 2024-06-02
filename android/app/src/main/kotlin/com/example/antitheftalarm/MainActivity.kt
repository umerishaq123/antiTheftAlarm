package com.example.antitheftalarm

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "dev.fluttercommunity.plus/sensors/method"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "setAccelerationSamplingPeriod") {
                // Implement your logic here
                // For instance, you might want to set the sampling period for sensor data
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }
}
