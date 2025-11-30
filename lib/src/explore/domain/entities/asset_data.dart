/// Asset data model for display in the explore list (stocks, mutual funds, etc.)
class AssetData {
  final String ticker;
  final String companyName;
  final String logoAbbreviation;
  final double currentPrice;
  final double change;
  final double changePercentage;
  final String assetTypeLabel;

  const AssetData({
    required this.ticker,
    required this.companyName,
    required this.logoAbbreviation,
    required this.currentPrice,
    required this.change,
    required this.changePercentage,
    required this.assetTypeLabel,
  });

  bool get isPositive => change >= 0;
  bool get isNeutral => change == 0;
}
