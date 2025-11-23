class PriceBar {
  final DateTime timestamp;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  PriceBar({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  double get change => close - open;
  bool get isPositive => change >= 0;
  double get changePercentage => (change / open) * 100;

  static List<PriceBar> generateMockData() {
    final now = DateTime.now();
    final data = <PriceBar>[];

    // Starting price around 0.89
    double basePrice = 0.89;

    // Generate 60 bars representing price movements similar to the screenshot
    for (int i = 0; i < 60; i++) {
      final date = now.subtract(Duration(days: 60 - i));

      // Simulate price movement with trend upward in the middle
      double priceChange = 0.0;
      if (i < 20) {
        // Initial downward trend
        priceChange = (i % 2 == 0 ? -0.001 : 0.0005);
      } else if (i < 45) {
        // Strong upward trend
        priceChange = (i % 3 == 0 ? 0.003 : 0.002);
      } else {
        // Consolidation with volatility
        priceChange = (i % 2 == 0 ? 0.001 : -0.0005);
      }

      basePrice += priceChange;

      final open = basePrice;
      final close = open + (i % 2 == 0 ? 0.002 : -0.001);
      final high = (open > close ? open : close) + 0.001;
      final low = (open < close ? open : close) - 0.001;
      final volume = 1000000 + (i * 50000);

      data.add(PriceBar(
        timestamp: date,
        open: open,
        high: high,
        low: low,
        close: close,
        volume: volume.toDouble(),
      ));
    }

    return data;
  }
}
