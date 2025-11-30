/// Centralized market status checker for Ghana Stock Exchange and Auction Market
class MarketStatus {
  MarketStatus._();

  /// Check if Ghana Stock Exchange is open
  /// Trading hours: 10:00 AM - 3:00 PM on weekdays, anytime on weekends
  static bool isStockMarketOpen() {
    final now = DateTime.now();

    // Open anytime on weekends
    if (now.weekday > 5) return true;

    final hour = now.hour;

    // Market opens at 10:00
    if (hour < 10) return false;

    // Market closes at 15:00 (3:00 PM)
    if (hour >= 15) return false;

    return true;
  }

  /// Check if Auction Market is open
  /// Auction hours: 9:00 AM - 12:00 PM on weekdays, anytime on weekends
  static bool isAuctionMarketOpen() {
    final now = DateTime.now();

    // Open anytime on weekends
    if (now.weekday > 5) return true;

    final hour = now.hour;

    // Auction opens at 9:00
    if (hour < 9) return false;

    // Auction closes at 12:00 PM
    if (hour >= 12) return false;

    return true;
  }

  /// Check if it's a weekday (trading day)
  static bool isTradingDay() {
    final now = DateTime.now();
    return now.weekday <= 5;
  }
}
