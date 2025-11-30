/// Stock data model for display in the explore list
class StockData {
  final String ticker;
  final String companyName;
  final String logoAbbreviation;
  final double currentPrice;
  final double change;
  final double changePercentage;

  const StockData({
    required this.ticker,
    required this.companyName,
    required this.logoAbbreviation,
    required this.currentPrice,
    required this.change,
    required this.changePercentage,
  });

  bool get isPositive => change >= 0;
  bool get isNeutral => change == 0;
}
