import 'package:flutter/material.dart';
import 'package:hazard/core/theme/app_colors_theme.dart';

class AppTheme {
  static ThemeData get theme => ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.background,
    cardColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.background),
    primaryColor: AppColors.sidebarGroup,
  );

  static ThemeData get darkTheme => ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
    appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1A1A1A)),
    primaryColor: Colors.lightBlueAccent.shade400,
  );
}
