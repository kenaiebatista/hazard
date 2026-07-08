import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  Locale _locale = const Locale('pt');
  ThemeMode _themeMode = ThemeMode.light;

  Locale get locale => _locale;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void setDarkMode(bool isDarkMode) {
    final mode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();
  }
}
