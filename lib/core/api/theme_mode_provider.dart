import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Enum for theme modes
enum AppThemeMode { system, light, dark }

// ChangeNotifier to manage theme state
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  // Load theme preference from shared preferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeIndex =
        prefs.getInt('themeMode') ?? 0; // Default to dark mode (index 2)
    _themeMode = ThemeMode.values[themeIndex];
    notifyListeners();
  }

  // Update theme and persist the choice
  Future<void> setTheme(AppThemeMode theme) async {
    final prefs = await SharedPreferences.getInstance();
    _themeMode = _mapAppThemeModeToThemeMode(theme);
    await prefs.setInt('themeMode', theme.index);
    notifyListeners();
  }

  // Helper function to map AppThemeMode to ThemeMode
  ThemeMode _mapAppThemeModeToThemeMode(AppThemeMode theme) {
    switch (theme) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
