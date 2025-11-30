import '../domain/entities/stock_data.dart';

/// Dummy data for the Explore tab
class DummyExploreData {
  DummyExploreData._();

  /// Get list of Ghana stocks for display
  static List<StockData> getGhanaStocks() {
    return const [
      StockData(
        ticker: 'MTNGH',
        companyName: 'Scancom PLC',
        logoAbbreviation: 'MTN',
        currentPrice: 4.02,
        change: 0.10,
        changePercentage: 2.3,
      ),
      StockData(
        ticker: 'EGH',
        companyName: 'Ecobank Ghana PLC',
        logoAbbreviation: 'Ecobank',
        currentPrice: 9.35,
        change: 0.33,
        changePercentage: 3.7,
      ),
      StockData(
        ticker: 'GCB',
        companyName: 'GCB Bank PLC',
        logoAbbreviation: 'EEBF',
        currentPrice: 13.50,
        change: 0.19,
        changePercentage: 1.4,
      ),
      StockData(
        ticker: 'BOPP',
        companyName: 'Benso Oil Palm Plantation PLC',
        logoAbbreviation: 'CCMF',
        currentPrice: 37.78,
        change: 3.43,
        changePercentage: 10.0,
      ),
      StockData(
        ticker: 'UNIL',
        companyName: 'Unilever Ghana PLC',
        logoAbbreviation: 'FBT',
        currentPrice: 20.00,
        change: 0.00,
        changePercentage: 0.0,
      ),
      StockData(
        ticker: 'CAL',
        companyName: 'Calbank PLC',
        logoAbbreviation: 'ICLF',
        currentPrice: 0.57,
        change: -0.10,
        changePercentage: -14.9,
      ),
    ];
  }
}
