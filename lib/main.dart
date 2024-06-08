import 'package:antitheftalarm/Anti_Theft_Alarm/splash_screen.dart';
import 'package:antitheftalarm/controller/ad_manager.dart';
import 'package:antitheftalarm/firebase_options.dart';
import 'package:antitheftalarm/theme/theme_light.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AdManager.init(); // Initialize Google AdMob

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
      title: 'Anti Theft Alarm',
      home: SplashScreen(),
    );
  }
}
