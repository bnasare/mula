enum TradeType {
  buy,
  sell;

  String get displayName {
    switch (this) {
      case TradeType.buy:
        return 'Buy';
      case TradeType.sell:
        return 'Sell';
    }
  }

  String get questionText {
    switch (this) {
      case TradeType.buy:
        return 'How much do you want to buy?';
      case TradeType.sell:
        return 'How much do you want to sell?';
    }
  }

  String get successTitle {
    switch (this) {
      case TradeType.buy:
        return 'Buy Successful';
      case TradeType.sell:
        return 'Sell Successful';
    }
  }
}
