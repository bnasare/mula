import 'package:flutter/material.dart';
import 'constants/app_text.dart';

class MarketStatusIndicator extends StatelessWidget {
  const MarketStatusIndicator({super.key});

  bool get _isMarketOpen {
    final now = DateTime.now();

    // Check if it's a weekday (Monday = 1, Friday = 5)
    if (now.weekday > 5) {
      return false; // Weekend
    }

    // Ghana Stock Exchange trading hours: 10:00 AM - 3:00 PM
    final hour = now.hour;

    // Market opens at 10:00
    if (hour < 10) return false;

    // Market closes at 15:00 (3:00 PM)
    if (hour >= 15) return false;

    return true;
  }

  @override
  Widget build(BuildContext context) {
    if (_isMarketOpen) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.1)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          AppText.smallest(
            'Market Closed',
            style: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
