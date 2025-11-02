import 'message_type.dart';

/// Represents a chat message in the Mula Bot conversation
class ChatMessage {
  final String id;
  final String text;
  final MessageType type;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.text,
    required this.type,
    required this.timestamp,
  });

  /// Check if this message is from the user
  bool get isUser => type == MessageType.user;

  /// Check if this message is from the bot
  bool get isBot => type == MessageType.bot;

  /// Create a copy with updated fields
  ChatMessage copyWith({
    String? id,
    String? text,
    MessageType? type,
    DateTime? timestamp,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      text: text ?? this.text,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
