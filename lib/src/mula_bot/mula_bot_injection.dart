import 'package:get_it/get_it.dart';

import 'presentation/provider/mula_bot_provider.dart';

final sl = GetIt.instance;

/// Initialize Mula Bot dependencies
void initMulaBot() {
  // Provider
  sl.registerFactory(() => MulaBotProvider());
}
