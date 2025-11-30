/// Data model for T-Bills and Bonds in Auction Market
class AuctionMarketItem {
  final String name;
  final String typeLabel;
  final String logoAbbreviation;
  final double interestRate;
  final String maturityDate;

  const AuctionMarketItem({
    required this.name,
    required this.typeLabel,
    required this.logoAbbreviation,
    required this.interestRate,
    required this.maturityDate,
  });
}

/// Data model for T-Bills and Bonds in Secondary Market
class SecondaryMarketItem {
  final String code;
  final String typeLabel;
  final String logoAbbreviation;
  final double rate;
  final double change;

  const SecondaryMarketItem({
    required this.code,
    required this.typeLabel,
    required this.logoAbbreviation,
    required this.rate,
    required this.change,
  });

  bool get isPositive => change >= 0;
  bool get isNeutral => change == 0;
}
