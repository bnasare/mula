import 'package:flutter/material.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/single_category_selector.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../data/dummy_learn_data.dart';

class LearnFilterBottomSheet extends StatefulWidget {
  final String? selectedDateRange;
  final String? selectedStock;
  final String? selectedCategory;

  const LearnFilterBottomSheet({
    super.key,
    this.selectedDateRange,
    this.selectedStock,
    this.selectedCategory,
  });

  static Future<Map<String, String?>?> show(
    BuildContext context, {
    String? selectedDateRange,
    String? selectedStock,
    String? selectedCategory,
  }) {
    return showModalBottomSheet<Map<String, String?>>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => LearnFilterBottomSheet(
        selectedDateRange: selectedDateRange,
        selectedStock: selectedStock,
        selectedCategory: selectedCategory,
      ),
    );
  }

  @override
  State<LearnFilterBottomSheet> createState() => _LearnFilterBottomSheetState();
}

class _LearnFilterBottomSheetState extends State<LearnFilterBottomSheet> {
  String? _selectedDateRange;
  String? _selectedStock;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _selectedDateRange = widget.selectedDateRange;
    _selectedStock = widget.selectedStock;
    _selectedCategory = widget.selectedCategory;
  }

  void _applyFilters() {
    Navigator.pop(context, {
      'dateRange': _selectedDateRange,
      'stock': _selectedStock,
      'category': _selectedCategory,
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateRanges = [
      context.localize.last30Days,
      context.localize.last60Days,
      context.localize.thisYear,
      context.localize.customDate,
    ];

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.medium(
                  context.localize.filter,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Date Range
            AppText.smaller(
              context.localize.dateRange,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: dateRanges.map((range) {
                final isSelected = _selectedDateRange == range;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDateRange = isSelected ? null : range;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.appPrimary.withOpacity(0.1)
                          : AppColors.card(context),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.appPrimary
                            : AppColors.lightGrey(context),
                      ),
                    ),
                    child: AppText.smallest(
                      range,
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.appPrimary
                            : AppColors.primaryText(context),
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            // Stock Selector
            SingleCategorySelector(
              title: context.localize.stock,
              hintText: context.localize.selectLevel,
              options: DummyLearnData.getStockLevels(),
              selectedOption: _selectedStock,
              onSelectionChanged: (value) {
                setState(() {
                  _selectedStock = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Category Selector
            SingleCategorySelector(
              title: context.localize.category,
              hintText: context.localize.selectCategory,
              options: DummyLearnData.getSearchCategories(),
              selectedOption: _selectedCategory,
              onSelectionChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            const SizedBox(height: 32),

            // Apply Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _applyFilters,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.appPrimary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: AppText.smaller(
                  context.localize.apply,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
