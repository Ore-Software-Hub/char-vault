import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle italicText(BuildContext context,
      {double size = 16, Color color = Colors.black}) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: FontWeight.w200,
      fontStyle: FontStyle.italic,
      color: color,
    );
  }

  static TextStyle lightText(BuildContext context,
      {double size = 16, Color color = Colors.black}) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: FontWeight.w200,
      color: color,
    );
  }

  static TextStyle boldText(BuildContext context,
      {double size = 16, Color color = Colors.black}) {
    return GoogleFonts.sarala(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: color,
    );
  }
}
