import 'package:antitheftalarm/theme/themecolors.dart';
import 'package:flutter/material.dart';

class Utils {
  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
          backgroundColor: Themecolor.flushbar,
          content: Text(
            message,
            style: const TextStyle(color: Themecolor.white),
          )));
  }
}
