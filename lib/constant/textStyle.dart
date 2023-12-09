import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyle(
    {required double size, required FontWeight fw, required Color color}) {
  return GoogleFonts.adamina(
      textStyle: TextStyle(
          color: color, fontWeight: fw, fontSize: size, letterSpacing: 1.5));
}

Color backGBcolor = const Color.fromRGBO(237, 95, 95, 1);
