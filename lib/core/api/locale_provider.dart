import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  // Supported locales mapping
  static const Map<String, Locale> supportedLocalesMap = {
    'English': Locale('en'),
    'Deutsch': Locale('de'),
    'Español': Locale('es'),
    'Français': Locale('fr'),
    'हिन्दी': Locale('hi'),
    'Italiano': Locale('it'),
    '日本語': Locale('ja'),
    'Nederlands': Locale('nl'),
    'Português': Locale('pt'),
    'Русский': Locale('ru'),
    '中文': Locale('zh'),
  };

  // Reverse mapping for getting language name from locale code
  static const Map<String, String> localeToLanguageName = {
    'en': 'English',
    'de': 'Deutsch',
    'es': 'Español',
    'fr': 'Français',
    'hi': 'हिन्दी',
    'it': 'Italiano',
    'ja': '日本語',
    'nl': 'Nederlands',
    'pt': 'Português',
    'ru': 'Русский',
    'zh': '中文',
  };

  LocaleProvider() {
    _loadLocale();
  }

  // Load locale preference from shared preferences
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final localeCode = prefs.getString('locale') ?? 'en';
    _locale = Locale(localeCode);
    notifyListeners();
  }

  // Update locale and persist the choice
  Future<void> setLocale(String languageName) async {
    final locale = supportedLocalesMap[languageName];
    if (locale != null) {
      final prefs = await SharedPreferences.getInstance();
      _locale = locale;
      await prefs.setString('locale', locale.languageCode);
      notifyListeners();
    }
  }

  // Get current language name
  String getCurrentLanguageName() {
    return localeToLanguageName[_locale.languageCode] ?? 'English';
  }

  // Get list of supported language names
  static List<String> getSupportedLanguageNames() {
    return supportedLocalesMap.keys.toList();
  }
}
