import 'package:equatable/equatable.dart';

/// Represents an asset in the portfolio
class Asset extends Equatable {
  final String name;
  final double value;
  final double percentage;
  final AssetType type;

  const Asset({
    required this.name,
    required this.value,
    required this.percentage,
    required this.type,
  });

  @override
  List<Object?> get props => [name, value, percentage, type];

  Asset copyWith({
    String? name,
    double? value,
    double? percentage,
    AssetType? type,
  }) {
    return Asset(
      name: name ?? this.name,
      value: value ?? this.value,
      percentage: percentage ?? this.percentage,
      type: type ?? this.type,
    );
  }
}

/// Types of assets that can be held in the portfolio
enum AssetType { stocks, tBills, cashWallet, reits, mutualFunds, bonds }

extension AssetTypeExtension on AssetType {
  String get displayName {
    switch (this) {
      case AssetType.stocks:
        return 'Stocks';
      case AssetType.tBills:
        return 'T-Bills';
      case AssetType.cashWallet:
        return 'Cash Wallet';
      case AssetType.reits:
        return 'REITs';
      case AssetType.mutualFunds:
        return 'Mutual Funds';
      case AssetType.bonds:
        return 'Bonds';
    }
  }
}
