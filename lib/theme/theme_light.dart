import 'package:antitheftalarm/theme/theme_text.dart';
import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:flutter/material.dart';


class Themelight {
  Themelight._();

  static ThemeData light_theme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFfefefe),
    appBarTheme: appbar_theme,
    textTheme: Themetext.textTheme,
    useMaterial3: true,
    elevatedButtonTheme: elevatedbuttontheme,
  );
  static AppBarTheme appbar_theme = const AppBarTheme(
      backgroundColor: Themecolor.primary,
      iconTheme: IconThemeData(color: Themecolor.white),
      titleTextStyle: TextStyle(color: Colors.white));

  static ElevatedButtonThemeData elevatedbuttontheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor:Themecolor.white,
      backgroundColor: Themecolor.primary,
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      minimumSize: const Size(327.0, 56.0),
    ),
  );
}
