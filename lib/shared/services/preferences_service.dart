import 'package:shared_preferences/shared_preferences.dart';

/// Service for managing app preferences using SharedPreferences
class PreferencesService {
  static const String _defaultHomePageKey = 'default_home_page';

  /// Save the default homepage index
  static Future<void> saveDefaultHomePage(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_defaultHomePageKey, index);
  }

  /// Get the saved default homepage index
  /// Returns null if no preference is saved
  static Future<int?> getDefaultHomePage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_defaultHomePageKey);
  }

  /// Clear the default homepage preference
  static Future<void> clearDefaultHomePage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_defaultHomePageKey);
  }

  // Notification preferences
  static const String _notificationPrefix = 'notification_pref_';

  /// Save a notification preference
  static Future<void> saveNotificationPreference(
    String key,
    bool value,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('$_notificationPrefix$key', value);
  }

  /// Get a notification preference (defaults to true if not set)
  static Future<bool> getNotificationPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$_notificationPrefix$key') ?? true;
  }

  /// Get all notification preferences
  static Future<Map<String, bool>> getAllNotificationPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = [
      'deposits_withdrawals',
      'trade_confirmations',
      'security_alerts',
      'price_alerts',
      'market_news',
      'portfolio_performance',
      'learning_reminders',
      'new_content',
    ];

    final Map<String, bool> preferences = {};
    for (final key in keys) {
      preferences[key] = prefs.getBool('$_notificationPrefix$key') ?? true;
    }
    return preferences;
  }

  // Mula Bot welcome screen preference
  static const String _mulaBotWelcomeShownKey = 'mula_bot_welcome_shown';

  /// Mark Mula Bot welcome screen as shown
  static Future<void> setMulaBotWelcomeShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_mulaBotWelcomeShownKey, true);
  }

  /// Check if Mula Bot welcome screen has been shown
  static Future<bool> isMulaBotWelcomeShown() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_mulaBotWelcomeShownKey) ?? false;
  }
}
