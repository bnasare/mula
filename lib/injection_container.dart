import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/api_service.dart';
import 'shared/platform/network_info.dart';
import 'src/onboarding/onboarding_injection.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Initialize sub-modules
  initOnboarding();

  // Register core dependencies
  sl
    ..registerLazySingleton(ApiService.new)
    ..registerLazySingleton<NetworkInfo>(NetworkInfoImpl.new);

  sl.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );

  await sl.allReady();
}
