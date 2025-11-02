import 'package:get_it/get_it.dart';
import 'presentation/provider/dashboard_provider.dart';

/// Initialize dashboard dependencies
/// Currently using dummy data, but structured for easy API integration
void initDashboard() {
  final sl = GetIt.instance;

  // Provider
  sl.registerFactory(() => DashboardProvider());

  // TODO: When adding real API integration, add:
  // - Repository implementations
  // - Use cases
  // - Data sources
  //
  // Example:
  // sl.registerLazySingleton<DashboardRepository>(
  //   () => DashboardRepositoryImpl(remoteDataSource: sl()),
  // );
  // sl.registerLazySingleton(() => GetPortfolioSummary(sl()));
  // sl.registerLazySingleton(() => GetRecentActivities(sl()));
}
