/// Notification entity representing a user notification
class NotificationEntity {
  final String id;
  final NotificationType type;
  final String title;
  final String description;
  final DateTime timestamp;
  final bool isRead;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    this.isRead = false,
  });

  /// Create a copy of this notification with updated fields
  NotificationEntity copyWith({
    String? id,
    NotificationType? type,
    String? title,
    String? description,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }
}

/// Types of notifications with their associated colors and icons
enum NotificationType {
  /// Portfolio gains, successful transactions (Green)
  success,

  /// Portfolio losses, warnings (Red/Orange)
  warning,

  /// Deposit confirmations (Blue)
  deposit,

  /// Withdrawal confirmations (Purple)
  withdrawal,

  /// General updates, system alerts (Grey)
  info,
}
