import '../../dashboard/domain/entities/activity.dart';
import '../../dashboard/domain/entities/asset.dart';
import '../../dashboard/domain/entities/portfolio_summary.dart';

/// Dummy data for the dashboard
/// This mimics what would come from an API
/// Structure is designed to be easily replaced with real API calls
class DummyDashboardData {
  /// Get portfolio summary
  /// In production, this would be an API call:
  /// Future<PortfolioSummary> getPortfolioSummary() async {
  ///   final response = await apiClient.get('/portfolio/summary');
  ///   return PortfolioSummary.fromJson(response.data);
  /// }
  static Future<PortfolioSummary> getPortfolioSummary() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return PortfolioSummary(
      totalValue: 12894.53,
      dailyChange: 148.29,
      dailyChangePercentage: 1.15,
      lastUpdated: DateTime.now(),
      assets: [
        const Asset(
          name: 'Stocks',
          value: 2098.00,
          percentage: 30.0,
          type: AssetType.stocks,
        ),
        const Asset(
          name: 'T-Bills',
          value: 3868.36,
          percentage: 25.0,
          type: AssetType.tBills,
        ),
        const Asset(
          name: 'Cash Wallet',
          value: 2578.91,
          percentage: 20.0,
          type: AssetType.cashWallet,
        ),
        const Asset(
          name: 'REITs',
          value: 2578.91,
          percentage: 15.0,
          type: AssetType.reits,
        ),
        const Asset(
          name: 'Mutual Funds',
          value: 1770.35,
          percentage: 10.0,
          type: AssetType.mutualFunds,
        ),
      ],
    );
  }

  /// Get recent activities
  /// In production, this would be an API call:
  /// Future<List<Activity>> getRecentActivities() async {
  ///   final response = await apiClient.get('/activities/recent');
  ///   return (response.data as List)
  ///       .map((json) => Activity.fromJson(json))
  ///       .toList();
  /// }
  static Future<List<Activity>> getRecentActivities() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final now = DateTime.now();

    return [
      Activity(
        id: '1',
        title: 'Scancom PLC',
        subtitle: 'Databank Brokerage',
        amount: 1500,
        type: ActivityType.buy,
        status: ActivityStatus.completed,
        timestamp: now.subtract(const Duration(hours: 2)),
        shares: '350 Shares',
      ),
      Activity(
        id: '2',
        title: 'CalBank Ltd',
        subtitle: 'Black Star Brokerage',
        amount: 2000,
        type: ActivityType.sell,
        status: ActivityStatus.pending,
        timestamp: now.subtract(const Duration(hours: 3)),
        shares: '200 Shares',
      ),
      Activity(
        id: '3',
        title: 'Mobile Money',
        subtitle: 'MTN Wallet',
        amount: 500,
        type: ActivityType.deposit,
        status: ActivityStatus.completed,
        timestamp: now.subtract(const Duration(hours: 5)),
      ),
      Activity(
        id: '4',
        title: 'Mobile Money',
        subtitle: 'MTN Wallet',
        amount: 500,
        type: ActivityType.deposit,
        status: ActivityStatus.completed,
        timestamp: now.subtract(const Duration(days: 1)),
      ),
    ];
  }

  /// Get user profile data
  /// In production, this would be an API call
  static Future<Map<String, dynamic>> getUserProfile() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return {
      'name': 'Phil Kyei',
      'email': 'phil.kyei@example.com',
      'profileImage': null, // No image for now
    };
  }
}
