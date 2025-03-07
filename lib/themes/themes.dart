import 'package:flutter/material.dart';
import 'package:CharVault/constants/cores.constants.dart' as cores;

ThemeData lightTheme = ThemeData(
  fontFamily: 'Worksans',
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    surface: cores.surfaceLight,
    onSurface: Colors.black,
    primary: cores.primaryLight,
    onPrimary: Colors.white,
    secondary: cores.secondaryLight,
    onSecondary: Colors.white,
  ),
);

ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Worksans',
  brightness: Brightness.dark,
  colorScheme: const ColorScheme.dark(
    surface: cores.surfaceDark,
    onSurface: Colors.white,
    primary: cores.primaryDark,
    onPrimary: Colors.black,
    secondary: cores.secondaryDark,
    onSecondary: Colors.black,
  ),
);
