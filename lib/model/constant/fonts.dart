import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppFonts {
  static TextStyle abyssinicaSilFonts({
    required double size,
    required Color color,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return GoogleFonts.abyssinicaSil(
      fontSize: size,
      color: color,
      fontWeight: fontWeight,
    );
  }
}
