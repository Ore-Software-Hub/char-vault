import 'package:flutter/material.dart';
import 'package:CharVault/constants/cores.constants.dart' as cores;

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: cores.primaryColor,
      onPrimary: Colors.white,
      secondary: cores.secondaryColor,
      onSecondary: Colors.white,
      error: Colors.redAccent,
      onError: Colors.white,
      surface: Color(0xFFFAFBFB),
      onSurface: Color(0xFF241E30),
    ),
  );

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

}
