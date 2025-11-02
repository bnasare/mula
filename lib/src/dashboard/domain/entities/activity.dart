import 'package:equatable/equatable.dart';

/// Represents a recent activity/transaction in the portfolio
class Activity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final ActivityType type;
  final ActivityStatus status;
  final DateTime timestamp;
  final String? shares;

  const Activity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.type,
    required this.status,
    required this.timestamp,
    this.shares,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        subtitle,
        amount,
        type,
        status,
        timestamp,
        shares,
      ];

  Activity copyWith({
    String? id,
    String? title,
    String? subtitle,
    double? amount,
    ActivityType? type,
    ActivityStatus? status,
    DateTime? timestamp,
    String? shares,
  }) {
    return Activity(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      shares: shares ?? this.shares,
    );
  }
}

/// Types of activities that can occur
enum ActivityType {
  buy,
  sell,
  deposit,
  withdrawal,
}

/// Status of the activity
enum ActivityStatus {
  completed,
  pending,
  failed,
}

extension ActivityTypeExtension on ActivityType {
  String get displayName {
    switch (this) {
      case ActivityType.buy:
        return 'Buy';
      case ActivityType.sell:
        return 'Sell';
      case ActivityType.deposit:
        return 'Deposit';
      case ActivityType.withdrawal:
        return 'Withdrawal';
    }
  }
}

extension ActivityStatusExtension on ActivityStatus {
  String get displayName {
    switch (this) {
      case ActivityStatus.completed:
        return 'Completed';
      case ActivityStatus.pending:
        return 'Pending';
      case ActivityStatus.failed:
        return 'Failed';
    }
  }
}
