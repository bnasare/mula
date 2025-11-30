import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../src/explore/data/dummy_explore_data.dart';
import '../../../src/learn/data/dummy_learn_data.dart';
import '../../../src/learn/presentation/interface/screens/lesson_detail_screen.dart';
import '../../../src/learn/presentation/interface/widgets/learn_filter_bottom_sheet.dart';
import '../../../src/portfolio/presentation/interface/screens/mutual_funds_detail_screen.dart';
import '../../../src/portfolio/presentation/interface/screens/stock_detail_screen.dart';
import '../../../src/portfolio/presentation/interface/screens/tbill_detail_screen.dart';
import '../../domain/entities/search_item.dart';
import '../../utils/localization_extension.dart';
import '../../utils/navigation.dart';
import '../theme/app_colors.dart';
import '../widgets/constants/app_text.dart';
import '../widgets/mula_app_bar.dart';
import '../widgets/mula_search_bar.dart';

enum SearchMode { assets, lessons }

class AssetSearchScreen extends StatefulWidget {
  final SearchMode searchMode;

  const AssetSearchScreen({super.key, this.searchMode = SearchMode.assets});

  @override
  State<AssetSearchScreen> createState() => _AssetSearchScreenState();
}

class _AssetSearchScreenState extends State<AssetSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchItem> _searchHistory = [];
  List<SearchItem> _popularSearches = [];
  List<SearchItem> _allSearchableItems = [];
  List<SearchItem> _searchResults = [];
  bool _isSearching = false;
  String _sortBy = 'Relevance';
  String? _selectedDateRange;
  String? _selectedStock;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadDataForMode();
  }

  void _loadDataForMode() {
    if (widget.searchMode == SearchMode.lessons) {
      _searchHistory = List.from(DummyLearnData.getLessonSearchHistory());
      _popularSearches = List.from(DummyLearnData.getPopularLessonSearches());
      _allSearchableItems = DummyLearnData.getAllSearchableLessons();
    } else {
      _searchHistory = List.from(DummyExploreData.getAssetSearchHistory());
      _popularSearches = List.from(DummyExploreData.getPopularAssetSearches());
      _allSearchableItems = DummyExploreData.getAllSearchableAssets();
    }
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
      });
      return;
    }

    final lowerQuery = query.toLowerCase();
    final results = _allSearchableItems.where((item) {
      final titleMatch = item.title.toLowerCase().contains(lowerQuery);
      final nameMatch = item.name?.toLowerCase().contains(lowerQuery) ?? false;
      final tickerMatch =
          item.ticker?.toLowerCase().contains(lowerQuery) ?? false;
      return titleMatch || nameMatch || tickerMatch;
    }).toList();

    setState(() {
      _isSearching = true;
      _searchResults = results;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _removeHistoryItem(String id) {
    setState(() {
      _searchHistory.removeWhere((item) => item.id == id);
    });
  }

  void _clearAll() {
    setState(() {
      _searchHistory.clear();
      _selectedDateRange = null;
      _selectedStock = null;
      _selectedCategory = null;
    });
  }

  void _openFilter() async {
    final result = await LearnFilterBottomSheet.show(
      context,
      selectedDateRange: _selectedDateRange,
      selectedStock: _selectedStock,
      selectedCategory: _selectedCategory,
    );

    if (result != null) {
      setState(() {
        _selectedDateRange = result['dateRange'];
        _selectedStock = result['stock'];
        _selectedCategory = result['category'];
      });
    }
  }

  void _navigateToDetail(SearchItem item) {
    switch (item.assetCategory) {
      case SearchAssetCategory.stock:
        NavigationHelper.navigateTo(
          context,
          StockDetailScreen(
            ticker: item.ticker ?? item.title,
            companyName: item.name ?? '',
            currentPrice: item.price ?? 0.0,
            change: item.change ?? 0.0,
            changePercentage: item.changePercentage ?? 0.0,
            showAppBarTitle: false,
          ),
        );
      case SearchAssetCategory.mutualFund:
        NavigationHelper.navigateTo(
          context,
          MutualFundsDetailScreen(
            ticker: item.ticker ?? item.title,
            fundName: item.name ?? '',
            currentPrice: item.price ?? 0.0,
            change: item.change ?? 0.0,
            changePercentage: item.changePercentage ?? 0.0,
            showAppBarTitle: false,
          ),
        );
      case SearchAssetCategory.tBill:
        NavigationHelper.navigateTo(
          context,
          TBillDetailScreen(
            tbillCode: item.ticker ?? item.title,
            description: item.name ?? '',
            currentRate: item.price ?? 0.0,
            change: item.change ?? 0.0,
            showAppBarTitle: false,
          ),
        );
      case SearchAssetCategory.lesson:
        NavigationHelper.navigateTo(
          context,
          LessonDetailScreen(lessonId: item.id),
        );
      case SearchAssetCategory.generic:
        // Do nothing for generic items
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.offWhite(context),
        appBar: MulaAppBar(
          title: '',
          showBackButton: true,
          onBackPressed: () => Navigator.of(context).pop(),
        ),
        body: Column(
          children: [
            // Search bar section
            Padding(
              padding: const EdgeInsets.all(16),
              child: MulaSearchBar(
                hintText: widget.searchMode == SearchMode.lessons
                    ? context.localize.searchLessons
                    : context.localize.searchByAsset,
                controller: _searchController,
                onChanged: _performSearch,
                trailing: GestureDetector(
                  onTap: _openFilter,
                  child: Icon(
                    IconlyLight.filter,
                    color: AppColors.defaultText(context),
                    size: 20,
                  ),
                ),
              ),
            ),

            // Sort and Clear section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  AppText.smaller(
                    context.localize.sortBy,
                    color: AppColors.secondaryText(context),
                  ),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: _sortBy,
                    underline: const SizedBox(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      size: 16,
                      color: AppColors.secondaryText(context),
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.primaryText(context),
                    ),
                    items: [context.localize.relevance, context.localize.date, context.localize.name].map((
                      String value,
                    ) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: AppText.smaller(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _sortBy = value;
                        });
                      }
                    },
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _clearAll,
                    child: AppText.smaller(
                      context.localize.clearAll,
                      style: TextStyle(
                        color: AppColors.appPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Search results/history
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  if (_isSearching) ...[
                    // Show search results
                    if (_searchResults.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: AppText.small(
                            context.localize.noResultsFound,
                            color: AppColors.secondaryText(context),
                          ),
                        ),
                      )
                    else
                      ..._searchResults.map(
                        (item) => _SearchResultTile(
                          item: item,
                          onTap: () => _navigateToDetail(item),
                        ),
                      ),
                  ] else ...[
                    // Search History
                    if (_searchHistory.isNotEmpty) ...[
                      ..._searchHistory.map(
                        (item) => _SearchItemTile(
                          title: item.title,
                          onTap: () => _navigateToDetail(item),
                          onRemove: () => _removeHistoryItem(item.id),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],

                    // Popular Section
                    AppText.small(
                      context.localize.popular,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    ..._popularSearches.map(
                      (item) => _SearchItemTile(
                        title: item.title,
                        onTap: () => _navigateToDetail(item),
                        onRemove: () {
                          // Popular items can't be removed
                        },
                        showRemoveButton: false,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchItemTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final bool showRemoveButton;

  const _SearchItemTile({
    required this.title,
    required this.onTap,
    required this.onRemove,
    this.showRemoveButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.secondaryText(context),
            ),
            const SizedBox(width: 16),
            Expanded(child: AppText.smaller(title)),
            if (showRemoveButton)
              GestureDetector(
                onTap: onRemove,
                child: Icon(
                  Icons.cancel,
                  size: 18,
                  color: AppColors.secondaryText(context),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SearchResultTile extends StatelessWidget {
  final SearchItem item;
  final VoidCallback onTap;

  const _SearchResultTile({required this.item, required this.onTap});

  String _getCategoryLabel(BuildContext context) {
    switch (item.assetCategory) {
      case SearchAssetCategory.stock:
        return context.localize.stock;
      case SearchAssetCategory.mutualFund:
        return context.localize.mutualFund;
      case SearchAssetCategory.tBill:
        return context.localize.tBill;
      case SearchAssetCategory.lesson:
        return context.localize.lesson;
      case SearchAssetCategory.generic:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.lightGrey(context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: AppText.smallest(
                  item.ticker?.substring(0, 2) ?? item.title.substring(0, 2),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.smaller(
                    item.title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  if (item.name != null)
                    AppText.smallest(
                      item.name!,
                      color: AppColors.secondaryText(context),
                    ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.lightGrey(context),
                borderRadius: BorderRadius.circular(4),
              ),
              child: AppText.smallest(
                _getCategoryLabel(context),
                style: TextStyle(
                  color: AppColors.secondaryText(context),
                  fontSize: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
