import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color bg = Color(0xffF5F1EB);
const Color dark = Color(0xff161616);
const Color light = Color(0xff8E8A84);
const Color gold = Color(0xffB79A63);
const Color goldLight = Color(0xffD4B97A);
const Color surface = Color(0xffEDE9E1);
const Color error = Color(0xff8B2020);

class AppTextStyles {
  static TextStyle display(double size, {Color color = dark}) =>
      GoogleFonts.cormorantGaramond(fontSize: size, color: color);

  static TextStyle label(double size,
          {Color color = gold,
          FontWeight weight = FontWeight.w600,
          double spacing = 2}) =>
      GoogleFonts.montserrat(
          fontSize: size,
          color: color,
          fontWeight: weight,
          letterSpacing: spacing);

  static TextStyle body(double size,
          {Color color = dark,
          FontWeight weight = FontWeight.normal}) =>
      GoogleFonts.montserrat(fontSize: size, color: color, fontWeight: weight);
}

InputDecoration luxeInputDecoration(String label, {String? hint}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    labelStyle: AppTextStyles.body(12, color: light),
    hintStyle: AppTextStyles.body(12, color: light),
    filled: true,
    fillColor: surface,
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: Color(0xffD6D0C5), width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: gold, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: error, width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide(color: error, width: 1.5),
    ),
  );
}