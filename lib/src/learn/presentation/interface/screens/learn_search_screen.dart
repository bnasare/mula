import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/mula_search_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../data/dummy_learn_data.dart';
import '../../../domain/entities/search_item.dart';
import '../widgets/learn_filter_bottom_sheet.dart';

class LearnSearchScreen extends StatefulWidget {
  const LearnSearchScreen({super.key});

  @override
  State<LearnSearchScreen> createState() => _LearnSearchScreenState();
}

class _LearnSearchScreenState extends State<LearnSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchItem> _searchHistory = [];
  List<SearchItem> _popularSearches = [];
  String _sortBy = 'Relevance';
  String? _selectedDateRange;
  String? _selectedStock;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _searchHistory = DummyLearnData.getSearchHistory();
    _popularSearches = DummyLearnData.getPopularSearches();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              hintText: context.localize.searchByAsset,
              controller: _searchController,
              onChanged: (value) {
                // TODO: Implement search
              },
              trailing: IconButton(
                icon: Icon(
                  IconlyLight.filter,
                  color: AppColors.primaryText(context),
                  size: 20,
                ),
                onPressed: _openFilter,
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
                  items: [context.localize.relevance, 'Date', 'Name']
                      .map((String value) {
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
                // Search History
                if (_searchHistory.isNotEmpty) ...[
                  ..._searchHistory.map((item) => _SearchItemTile(
                        title: item.title,
                        onTap: () {
                          // TODO: Navigate to search result
                        },
                        onRemove: () => _removeHistoryItem(item.id),
                      )),
                  const SizedBox(height: 24),
                ],

                // Popular Section
                AppText.small(
                  context.localize.popular,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                ..._popularSearches.map((item) => _SearchItemTile(
                      title: item.title,
                      onTap: () {
                        // TODO: Navigate to search result
                      },
                      onRemove: () {
                        // Popular items can't be removed
                      },
                      showRemoveButton: false,
                    )),
              ],
            ),
          ),
        ],
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
            Expanded(
              child: AppText.smaller(title),
            ),
            if (showRemoveButton)
              IconButton(
                icon: Icon(
                  Icons.close,
                  size: 20,
                  color: AppColors.secondaryText(context),
                ),
                onPressed: onRemove,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
          ],
        ),
      ),
    );
  }
}
