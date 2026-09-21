import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/resources/styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: false,
        textTheme: TextTheme(
          displayLarge: AppStyle.displayLarge,
          displayMedium: AppStyle.displayMedium,
          displaySmall: AppStyle.displaySmall,
          headlineMedium: AppStyle.headlineMedium,
          headlineSmall: AppStyle.headlineSmall,
          titleLarge: AppStyle.titleLarge,
          titleMedium: AppStyle.titleMedium,
          titleSmall: AppStyle.titleSmall,
          bodyLarge: AppStyle.bodyLarge,
          bodyMedium: AppStyle.bodyMedium,
          bodySmall: AppStyle.bodySmall,
          labelLarge: AppStyle.labelLarge,
          labelSmall: AppStyle.labelSmall,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        appBarTheme: const AppBarTheme(color: Color(0xFF394797)),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1BA1E2),
            minimumSize: const Size.fromHeight(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        listTileTheme: const ListTileThemeData(
          style: ListTileStyle.drawer,
          dense: true,
        ),
      );

  static ThemeData get dartTheme =>
      lightTheme.copyWith(brightness: Brightness.dark);
}
