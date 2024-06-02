import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AirPodsDetection extends StatefulWidget {
  @override
  _AirPodsDetectionState createState() => _AirPodsDetectionState();
}

class _AirPodsDetectionState extends State<AirPodsDetection> {
  String _bluetoothStatus = 'Unknown';

  @override
  void initState() {
    super.initState();
    _checkBluetoothStatus();
  }

  Future<void> _checkBluetoothStatus() async {
    String bluetoothStatus;
    try {
      // Call platform-specific method to check Bluetooth status
      bluetoothStatus = await _getBluetoothStatus();
    } on PlatformException catch (e) {
      bluetoothStatus = 'Failed to get Bluetooth status: ${e.message}';
    }

    setState(() {
      _bluetoothStatus = bluetoothStatus;
    });
  }

  Future<String> _getBluetoothStatus() async {
    // Call platform method channel to invoke native method
    final MethodChannel platform =
        MethodChannel('com.example.airpods_detection/bluetooth');
    final String bluetoothStatus =
        await platform.invokeMethod('getBluetoothStatus');
    return bluetoothStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AirPods Detection'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bluetooth Status: $_bluetoothStatus',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
