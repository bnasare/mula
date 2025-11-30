import 'package:flutter/foundation.dart';

import '../../../../shared/services/preferences_service.dart';
import '../../data/dummy_dashboard_data.dart';
import '../../domain/entities/activity.dart';
import '../../domain/entities/portfolio_summary.dart';

/// Provider for managing dashboard state
class DashboardProvider extends ChangeNotifier {
  int _currentTabIndex = 0;
  bool _hasLoadedDefaultTab = false;
  PortfolioSummary? _portfolioSummary;
  List<Activity> _recentActivities = [];
  Map<String, dynamic>? _userProfile;
  bool _isLoadingPortfolio = false;
  bool _isLoadingActivities = false;
  bool _isLoadingProfile = false;
  String? _error;

  // Getters
  int get currentTabIndex => _currentTabIndex;
  bool get hasLoadedDefaultTab => _hasLoadedDefaultTab;
  PortfolioSummary? get portfolioSummary => _portfolioSummary;
  List<Activity> get recentActivities => _recentActivities;
  Map<String, dynamic>? get userProfile => _userProfile;
  bool get isLoadingPortfolio => _isLoadingPortfolio;
  bool get isLoadingActivities => _isLoadingActivities;
  bool get isLoadingProfile => _isLoadingProfile;
  String? get error => _error;
  bool get isLoading =>
      _isLoadingPortfolio || _isLoadingActivities || _isLoadingProfile;

  /// Load the default tab from preferences
  Future<void> loadDefaultTab() async {
    if (_hasLoadedDefaultTab) return;

    final defaultTab = await PreferencesService.getDefaultHomePage();
    if (defaultTab != null && defaultTab >= 0 && defaultTab <= 4) {
      _currentTabIndex = defaultTab;
      _hasLoadedDefaultTab = true;
      notifyListeners();
    } else {
      _hasLoadedDefaultTab = true;
    }
  }

  /// Change the current tab
  void changeTab(int index) {
    if (_currentTabIndex != index) {
      _currentTabIndex = index;
      notifyListeners();
    }
  }

  /// Save the current tab as the default homepage
  Future<void> saveAsDefaultHomePage(int index) async {
    await PreferencesService.saveDefaultHomePage(index);
  }

  /// Load portfolio summary
  /// In production, replace DummyDashboardData with actual API repository
  Future<void> loadPortfolioSummary() async {
    _isLoadingPortfolio = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call when ready
      // Example: _portfolioSummary = await _portfolioRepository.getSummary();
      _portfolioSummary = await DummyDashboardData.getPortfolioSummary();
    } catch (e) {
      _error = 'Failed to load portfolio summary: ${e.toString()}';
      debugPrint(_error);
    } finally {
      _isLoadingPortfolio = false;
      notifyListeners();
    }
  }

  /// Load recent activities
  /// In production, replace DummyDashboardData with actual API repository
  Future<void> loadRecentActivities() async {
    _isLoadingActivities = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call when ready
      // Example: _recentActivities = await _activityRepository.getRecent();
      _recentActivities = await DummyDashboardData.getRecentActivities();
    } catch (e) {
      _error = 'Failed to load activities: ${e.toString()}';
      debugPrint(_error);
    } finally {
      _isLoadingActivities = false;
      notifyListeners();
    }
  }

  /// Load user profile
  /// In production, replace DummyDashboardData with actual API repository
  Future<void> loadUserProfile() async {
    _isLoadingProfile = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call when ready
      // Example: _userProfile = await _userRepository.getProfile();
      _userProfile = await DummyDashboardData.getUserProfile();
    } catch (e) {
      _error = 'Failed to load user profile: ${e.toString()}';
      debugPrint(_error);
    } finally {
      _isLoadingProfile = false;
      notifyListeners();
    }
  }

  /// Load all dashboard data
  Future<void> loadDashboardData() async {
    await Future.wait([
      loadPortfolioSummary(),
      loadRecentActivities(),
      loadUserProfile(),
    ]);
  }

  /// Refresh dashboard data
  Future<void> refresh() async {
    await loadDashboardData();
  }

  /// Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}
