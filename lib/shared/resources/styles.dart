import 'package:flutter/material.dart';

class AppStyle {
  AppStyle._();

  static TextStyle get displayLarge => const TextStyle();

  static TextStyle get displayMedium => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get displaySmall => const TextStyle();

  static TextStyle get headlineMedium => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get headlineSmall => const TextStyle();

  static TextStyle get titleLarge => const TextStyle();

  static TextStyle get titleMedium => const TextStyle(
        fontWeight: FontWeight.w500,
      );

  static TextStyle get titleSmall => const TextStyle();

  static TextStyle get bodyLarge => const TextStyle();

  static TextStyle get bodyMedium => const TextStyle();

  static TextStyle get bodySmall => const TextStyle();

  static TextStyle get labelLarge => const TextStyle();

  static TextStyle get labelSmall => const TextStyle();
}
