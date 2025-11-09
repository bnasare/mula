import 'package:equatable/equatable.dart';
import 'asset.dart';

/// Represents the summary of a user's portfolio
class PortfolioSummary extends Equatable {
  final double totalValue;
  final double dailyChange;
  final double dailyChangePercentage;
  final List<Asset> assets;
  final DateTime lastUpdated;

  const PortfolioSummary({
    required this.totalValue,
    required this.dailyChange,
    required this.dailyChangePercentage,
    required this.assets,
    required this.lastUpdated,
  });

  @override
  List<Object?> get props => [
    totalValue,
    dailyChange,
    dailyChangePercentage,
    assets,
    lastUpdated,
  ];

  PortfolioSummary copyWith({
    double? totalValue,
    double? dailyChange,
    double? dailyChangePercentage,
    List<Asset>? assets,
    DateTime? lastUpdated,
  }) {
    return PortfolioSummary(
      totalValue: totalValue ?? this.totalValue,
      dailyChange: dailyChange ?? this.dailyChange,
      dailyChangePercentage:
          dailyChangePercentage ?? this.dailyChangePercentage,
      assets: assets ?? this.assets,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  /// Check if the daily change is positive
  bool get isPositiveChange => dailyChange >= 0;

  /// Get the total value of a specific asset type
  double getAssetValue(AssetType type) {
    try {
      return assets.firstWhere((asset) => asset.type == type).value;
    } catch (e) {
      return 0.0;
    }
  }

  /// Get the percentage of a specific asset type
  double getAssetPercentage(AssetType type) {
    try {
      return assets.firstWhere((asset) => asset.type == type).percentage;
    } catch (e) {
      return 0.0;
    }
  }
}
