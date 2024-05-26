
import 'package:antitheftalarm/Anti_Theft_Alarm/air_Phone_detection.dart';
import 'package:antitheftalarm/Anti_Theft_Alarm/avoid_overcharging.dart';
import 'package:antitheftalarm/theme/theme_light.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themelight.light_theme,
      title: 'Flutter Demo',
      
      home: AirphonesDetection(),
    );
  }
}

