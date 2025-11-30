import '../../../shared/domain/entities/search_item.dart';
import '../domain/entities/asset_data.dart';
import '../domain/entities/tbill_bond_data.dart';

/// Dummy data for the Explore tab
class DummyExploreData {
  DummyExploreData._();

  /// Get list of Ghana stocks for display
  static List<AssetData> getGhanaStocks() {
    return const [
      AssetData(
        ticker: 'MTNGH',
        companyName: 'Scancom PLC',
        logoAbbreviation: 'MTN',
        currentPrice: 4.02,
        change: 0.10,
        changePercentage: 2.3,
        assetTypeLabel: 'Equity',
      ),
      AssetData(
        ticker: 'EGH',
        companyName: 'Ecobank Ghana PLC',
        logoAbbreviation: 'Ecobank',
        currentPrice: 9.35,
        change: 0.33,
        changePercentage: 3.7,
        assetTypeLabel: 'Equity',
      ),
      AssetData(
        ticker: 'GCB',
        companyName: 'GCB Bank PLC',
        logoAbbreviation: 'EEBF',
        currentPrice: 13.50,
        change: 0.19,
        changePercentage: 1.4,
        assetTypeLabel: 'Equity',
      ),
      AssetData(
        ticker: 'BOPP',
        companyName: 'Benso Oil Palm Plantation PLC',
        logoAbbreviation: 'CCMF',
        currentPrice: 37.78,
        change: 3.43,
        changePercentage: 10.0,
        assetTypeLabel: 'Equity',
      ),
      AssetData(
        ticker: 'UNIL',
        companyName: 'Unilever Ghana PLC',
        logoAbbreviation: 'FBT',
        currentPrice: 20.00,
        change: 0.00,
        changePercentage: 0.0,
        assetTypeLabel: 'Equity',
      ),
      AssetData(
        ticker: 'CAL',
        companyName: 'Calbank PLC',
        logoAbbreviation: 'ICLF',
        currentPrice: 0.57,
        change: -0.10,
        changePercentage: -14.9,
        assetTypeLabel: 'Equity',
      ),
    ];
  }

  /// Get list of Mutual Funds for display
  static List<AssetData> getMutualFunds() {
    return const [
      AssetData(
        ticker: 'ICLF',
        companyName: 'IC Liquidity Fund',
        logoAbbreviation: 'ICLF',
        currentPrice: 2.0231,
        change: -0.02,
        changePercentage: -1.2,
        assetTypeLabel: 'Mutual Fund',
      ),
      AssetData(
        ticker: 'MFUND',
        companyName: 'Databank Mfund',
        logoAbbreviation: 'MTN',
        currentPrice: 2.7844,
        change: 0.12,
        changePercentage: 4.7,
        assetTypeLabel: 'Mutual Fund',
      ),
      AssetData(
        ticker: 'BFUND',
        companyName: 'Databank Balanced Fund',
        logoAbbreviation: 'Ecobank',
        currentPrice: 1.5053,
        change: 0.03,
        changePercentage: 4.7,
        assetTypeLabel: 'Mutual Fund',
      ),
      AssetData(
        ticker: 'EEBF',
        companyName: 'Enhanced Equity Beta Fund',
        logoAbbreviation: 'EEBF',
        currentPrice: 3.0909,
        change: 0.04,
        changePercentage: 4.7,
        assetTypeLabel: 'Mutual Fund',
      ),
      AssetData(
        ticker: 'CCMF',
        companyName: 'Christian Community Mutual Fund',
        logoAbbreviation: 'CCMF',
        currentPrice: 1.3550,
        change: 0.17,
        changePercentage: 4.7,
        assetTypeLabel: 'Mutual Fund',
      ),
      AssetData(
        ticker: 'FBT',
        companyName: 'Fidelity Balanced Trust',
        logoAbbreviation: 'FBT',
        currentPrice: 0.2001,
        change: 0.00,
        changePercentage: 0.0,
        assetTypeLabel: 'Mutual Fund',
      ),
    ];
  }

  /// Get list of Auction Market items (T-Bills and Bonds)
  static List<AuctionMarketItem> getAuctionMarketItems() {
    return const [
      AuctionMarketItem(
        name: '91-Day Bill',
        typeLabel: 'Treasury Bills',
        logoAbbreviation: '91D',
        interestRate: 15.53,
        maturityDate: '18-JAN-25',
      ),
      AuctionMarketItem(
        name: '182-Day Bill',
        typeLabel: 'Treasury Bills',
        logoAbbreviation: '182D',
        interestRate: 16.25,
        maturityDate: '18-APR-25',
      ),
      AuctionMarketItem(
        name: '364-Day Bill',
        typeLabel: 'Treasury Bill',
        logoAbbreviation: '364D',
        interestRate: 17.80,
        maturityDate: '18-OCT-25',
      ),
      AuctionMarketItem(
        name: 'Government of Ghana',
        typeLabel: 'Bonds',
        logoAbbreviation: 'GOG',
        interestRate: 19.50,
        maturityDate: '18-OCT-28',
      ),
      AuctionMarketItem(
        name: 'Corporates',
        typeLabel: 'Bonds',
        logoAbbreviation: 'CB',
        interestRate: 21.00,
        maturityDate: '18-JAN-27',
      ),
    ];
  }

  /// Get list of Secondary Market items (T-Bills and Bonds)
  static List<SecondaryMarketItem> getSecondaryMarketItems() {
    return const [
      SecondaryMarketItem(
        code: 'TB 27-OCT-25',
        typeLabel: 'Treasury Bill',
        logoAbbreviation: 'TB',
        rate: 10.83,
        change: 2.3,
      ),
      SecondaryMarketItem(
        code: 'TB 30-NOV-25',
        typeLabel: 'Treasury Bill',
        logoAbbreviation: 'TB',
        rate: 11.52,
        change: 1.8,
      ),
      SecondaryMarketItem(
        code: 'TB 15-DEC-25',
        typeLabel: 'Treasury Bill',
        logoAbbreviation: 'TB',
        rate: 12.94,
        change: 0.9,
      ),
      SecondaryMarketItem(
        code: 'GOG 18-OCT-28',
        typeLabel: '3-Year Bond',
        logoAbbreviation: 'GOG',
        rate: 7.65,
        change: 0.4,
      ),
      SecondaryMarketItem(
        code: 'GOG 21-SEP-29',
        typeLabel: '5-Year Bond',
        logoAbbreviation: 'GOG',
        rate: 8.81,
        change: 0.0,
      ),
      SecondaryMarketItem(
        code: 'GOG 27-OCT-32',
        typeLabel: '10-Year Bond',
        logoAbbreviation: 'GOG',
        rate: 9.27,
        change: 0.1,
      ),
      SecondaryMarketItem(
        code: 'CB 27-MAR-26',
        typeLabel: 'Dalex Bond',
        logoAbbreviation: 'DLX',
        rate: 6.65,
        change: 0.0,
      ),
      SecondaryMarketItem(
        code: 'CB 27-JAN-27',
        typeLabel: 'Letshego Bond',
        logoAbbreviation: 'LTS',
        rate: 8.43,
        change: 4.7,
      ),
    ];
  }

  /// Get asset search history
  static List<SearchItem> getAssetSearchHistory() {
    return const [
      SearchItem(
        id: 'ah1',
        title: 'MTNGH',
        type: SearchItemType.history,
        assetCategory: SearchAssetCategory.stock,
        ticker: 'MTNGH',
        name: 'Scancom PLC',
        price: 4.02,
        change: 0.10,
        changePercentage: 2.3,
      ),
      SearchItem(
        id: 'ah2',
        title: 'CCMF',
        type: SearchItemType.history,
        assetCategory: SearchAssetCategory.mutualFund,
        ticker: 'CCMF',
        name: 'Christian Community Mutual Fund',
        price: 1.3550,
        change: 0.17,
        changePercentage: 4.7,
      ),
      SearchItem(
        id: 'ah3',
        title: 'TB 27-OCT-25',
        type: SearchItemType.history,
        assetCategory: SearchAssetCategory.tBill,
        ticker: 'TB 27-OCT-25',
        name: 'Treasury Bill',
        price: 10.83,
        change: 2.3,
        changePercentage: 2.3,
      ),
    ];
  }

  /// Get popular asset searches
  static List<SearchItem> getPopularAssetSearches() {
    return const [
      SearchItem(
        id: 'ap1',
        title: 'EGH',
        type: SearchItemType.popular,
        assetCategory: SearchAssetCategory.stock,
        ticker: 'EGH',
        name: 'Ecobank Ghana PLC',
        price: 9.35,
        change: 0.33,
        changePercentage: 3.7,
      ),
      SearchItem(
        id: 'ap2',
        title: 'MFUND',
        type: SearchItemType.popular,
        assetCategory: SearchAssetCategory.mutualFund,
        ticker: 'MFUND',
        name: 'Databank Mfund',
        price: 2.7844,
        change: 0.12,
        changePercentage: 4.7,
      ),
      SearchItem(
        id: 'ap3',
        title: 'TB 30-NOV-25',
        type: SearchItemType.popular,
        assetCategory: SearchAssetCategory.tBill,
        ticker: 'TB 30-NOV-25',
        name: 'Treasury Bill',
        price: 11.52,
        change: 1.8,
        changePercentage: 1.8,
      ),
    ];
  }

  /// Get all searchable assets (stocks, mutual funds, T-bills) as SearchItem list
  static List<SearchItem> getAllSearchableAssets() {
    final List<SearchItem> items = [];

    // Add stocks
    for (final stock in getGhanaStocks()) {
      items.add(SearchItem(
        id: 'stock_${stock.ticker}',
        title: stock.ticker,
        type: SearchItemType.popular,
        assetCategory: SearchAssetCategory.stock,
        ticker: stock.ticker,
        name: stock.companyName,
        price: stock.currentPrice,
        change: stock.change,
        changePercentage: stock.changePercentage,
      ));
    }

    // Add mutual funds
    for (final fund in getMutualFunds()) {
      items.add(SearchItem(
        id: 'fund_${fund.ticker}',
        title: fund.ticker,
        type: SearchItemType.popular,
        assetCategory: SearchAssetCategory.mutualFund,
        ticker: fund.ticker,
        name: fund.companyName,
        price: fund.currentPrice,
        change: fund.change,
        changePercentage: fund.changePercentage,
      ));
    }

    // Add secondary market T-bills/bonds
    for (final item in getSecondaryMarketItems()) {
      items.add(SearchItem(
        id: 'tbill_${item.code}',
        title: item.code,
        type: SearchItemType.popular,
        assetCategory: SearchAssetCategory.tBill,
        ticker: item.code,
        name: item.typeLabel,
        price: item.rate,
        change: item.change,
        changePercentage: item.change,
      ));
    }

    return items;
  }
}
