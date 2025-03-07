import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle lightText(BuildContext context, {double size = 16}) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: FontWeight.w200,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }

  static TextStyle boldText(BuildContext context, {double size = 16}) {
    return GoogleFonts.sarala(
      fontSize: size,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.onSurface,
    );
  }
}
