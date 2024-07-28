// snackbar_helper.dart
import 'package:flutter/material.dart';

class NotificationHelper {
  static void showSnackBar(BuildContext context, String message,
      {int duration = 3}) {
    final snackBar = SnackBar(
        content: Text(message),
        duration: Duration(seconds: duration),
        behavior: SnackBarBehavior.floating,
        shape: const StadiumBorder());
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
