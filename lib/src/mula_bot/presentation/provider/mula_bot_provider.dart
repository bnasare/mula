import 'package:flutter/foundation.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/message_type.dart';

/// Provider for managing Mula Bot chat state
class MulaBotProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = [];
  bool _isTyping = false;
  String? _error;

  List<ChatMessage> get messages => List.unmodifiable(_messages);
  bool get isTyping => _isTyping;
  String? get error => _error;

  /// Send a message from the user
  Future<void> sendMessage(String text, {String? userName}) async {
    if (text.trim().isEmpty) return;

    // Add user message
    final userMessage = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      text: text.trim(),
      type: MessageType.user,
      timestamp: DateTime.now(),
    );

    _messages.add(userMessage);
    notifyListeners();

    // Show typing indicator
    _isTyping = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 2));

      // Get mock AI response
      final botResponse = _getMockResponse(text, userName: userName);

      final botMessage = ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: botResponse,
        type: MessageType.bot,
        timestamp: DateTime.now(),
      );

      _messages.add(botMessage);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isTyping = false;
      notifyListeners();
    }
  }

  /// Clear all messages
  void clearMessages() {
    _messages.clear();
    _error = null;
    notifyListeners();
  }

  /// Get initial greeting message
  String getGreeting(String? userName) {
    final name = userName ?? 'there';
    return 'Hi $name👋 What/\'s on your mind?';
  }

  /// Generate mock AI response based on user input
  String _getMockResponse(String userMessage, {String? userName}) {
    final lowercaseMessage = userMessage.toLowerCase();

    if (lowercaseMessage.contains('beginner') ||
        lowercaseMessage.contains('invest') &&
            lowercaseMessage.contains('plan')) {
      return '''Beginner Investment Plan:
1. Build an Emergency Fund: Save 3-6 months of your expenses in a high-interest savings account or money-market fund in Ghana. This gives you quick access to cash if needed.

2. Create a Stable Base: Put 60-70% of your money into short-term Treasury bills or a money-market mutual fund for safety and stability.

3. Add Some Growth: Invest 20-30% into a diversified mutual fund or balanced fund for gradual long-term growth.

4. Check Quarterly: Every 3 months, review your mix. If one part grows too much or too little, adjust to keep balance.

⚠️ Note: This is for educational purposes only and not financial advice. Always review your personal situation or speak with a licensed advisor if unsure.''';
    }

    if (lowercaseMessage.contains('low risk') ||
        lowercaseMessage.contains('safe')) {
      return '''For low-risk investments, consider:

1. Treasury Bills (T-Bills): Government-backed, very safe, returns around 25-30% annually
2. Fixed Deposits: Stable returns from banks, locked for specific periods
3. Money Market Funds: Managed by fund managers, very liquid and low risk

Would you like me to explain more about any of these options?''';
    }

    if (lowercaseMessage.contains('help') || lowercaseMessage.contains('how')) {
      return '''I can help you with:
- Creating investment plans based on your goals
- Explaining different investment types
- Answering questions about stocks, bonds, T-bills
- Portfolio diversification advice
- Risk assessment

What would you like to know more about?''';
    }

    // Default response
    return '''That\\'s a great question! I\\'m here to help you understand investing better.

Could you tell me more about:
- Your investment goals?
- Your risk tolerance (low, medium, high)?
- Your investment timeline?

This will help me give you more specific guidance.''';
  }

  /// Get suggested prompts for the user
  List<String> getSuggestedPrompts() {
    return [
      'Which investments are low risk?',
      'Suggest a beginner investment plan',
      'How do I start investing?',
      'Explain Treasury Bills',
    ];
  }
}
