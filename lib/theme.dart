import 'package:flutter/material.dart';

class AppColors {
  static Color primary = const Color(0xFF112D4E);
  static Color secondary = const Color(0xFF3F72AF);
  static Color light = const Color(0xFFDBE2EF);
  static Color white = const Color(0xFFF9F7F7);
}

class LangWhaleTheme {
  static ThemeData theme() {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme.fromSwatch(accentColor: AppColors.secondary),
      fontFamily: 'Ubuntu',
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.white,
        titleTextStyle: const TextStyle(
          fontSize: 25,
          fontFamily: "Ubuntu",
          fontWeight: FontWeight.w400,
        ),
      ),
      // dialogTheme: DialogTheme(
      //   backgroundColor: AppColors.secondary,
      //   titleTextStyle: TextStyle(
      //     fontFamily: 'Ubuntu',
      //     fontSize: 18,
      //     fontWeight: FontWeight.w600,
      //     color: AppColors.white,
      //   ),
      //   contentTextStyle: TextStyle(
      //     fontFamily: 'Ubuntu',
      //     color: AppColors.white,
      //   ),
      // ),
    );
  }
}
