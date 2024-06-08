import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BluetoothConnectionStatus extends StatefulWidget {
  @override
  _BluetoothConnectionStatusState createState() => _BluetoothConnectionStatusState();
}

class _BluetoothConnectionStatusState extends State<BluetoothConnectionStatus> {
  bool _isBluetoothSupported = false;
  bool _isBluetoothOn = false;

  @override
  void initState() {
    super.initState();
    _checkBluetoothSupport();
  }

  Future<void> _checkBluetoothSupport() async {
    // Check if Bluetooth is supported by the device
    _isBluetoothSupported = await FlutterBluePlus.isSupported;
    if (!_isBluetoothSupported) {
      print("Bluetooth not supported by this device");
      return;
    }

    // Subscribe to Bluetooth adapter state changes
    var subscription = FlutterBluePlus.adapterState.listen((BluetoothAdapterState state) {
      print(state);
      setState(() {
        _isBluetoothOn = state == BluetoothAdapterState.on;
      });
      if (state == BluetoothAdapterState.on) {
        // Bluetooth is on, you can start scanning for devices or perform other operations
      } else {
        // Bluetooth is off, handle the situation accordingly
      }
    });

    // Turn on Bluetooth on Android devices
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    // Cancel the subscription to prevent duplicate listeners
    subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Connection Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Bluetooth Supported: $_isBluetoothSupported',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Text(
              'Bluetooth On: $_isBluetoothOn',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
