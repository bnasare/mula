import 'package:shared_preferences/shared_preferences.dart';

abstract class OnboardingLocalDatabase {
  Future<bool> isOnboardingComplete();
  Future<void> completeOnboarding();
  Future<void> resetOnboarding();
}

class OnboardingLocalDatabaseImpl implements OnboardingLocalDatabase {
  static const onboardingCompleteKey = 'onboardingComplete';
  @override
  Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onboardingCompleteKey) ?? false;
  }

  @override
  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingCompleteKey, true);
  }

  @override
  Future<void> resetOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(onboardingCompleteKey, false);
  }
}
