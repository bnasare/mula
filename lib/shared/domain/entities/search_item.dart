/// Asset category for search items to determine navigation target
enum SearchAssetCategory { stock, mutualFund, tBill, lesson, generic }

/// Type of search item (history or popular suggestion)
enum SearchItemType { history, popular }

/// Search item model with navigation data
class SearchItem {
  final String id;
  final String title;
  final SearchItemType type;
  final SearchAssetCategory assetCategory;

  // Optional fields for navigation to detail screens
  final String? ticker;
  final String? name;
  final double? price;
  final double? change;
  final double? changePercentage;

  const SearchItem({
    required this.id,
    required this.title,
    required this.type,
    required this.assetCategory,
    this.ticker,
    this.name,
    this.price,
    this.change,
    this.changePercentage,
  });
}
