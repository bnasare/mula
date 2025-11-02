import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/api_service.dart';
import 'shared/platform/network_info.dart';
import 'src/account/account_injection.dart';
import 'src/dashboard/dashboard_injection.dart';
import 'src/explore/explore_injection.dart';
import 'src/home/home_injection.dart';
import 'src/learn/learn_injection.dart';
import 'src/onboarding/onboarding_injection.dart';
import 'src/portfolio/portfolio_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize sub-modules
  initOnboarding();
  initDashboard();
  initHome();
  initExplore();
  initPortfolio();
  initLearn();
  initAccount();

  // Register core dependencies
  sl
    ..registerLazySingleton(ApiService.new)
    ..registerLazySingleton<NetworkInfo>(NetworkInfoImpl.new);

  sl.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );

  await sl.allReady();
}
