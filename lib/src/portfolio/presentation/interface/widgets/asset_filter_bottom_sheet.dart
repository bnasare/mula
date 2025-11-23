import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../authentication/presentation/interface/widgets/mula_text_field.dart';

/// Bottom sheet for filtering asset holdings
class AssetFilterBottomSheet extends StatefulWidget {
  const AssetFilterBottomSheet({super.key});

  @override
  State<AssetFilterBottomSheet> createState() => _AssetFilterBottomSheetState();
}

class _AssetFilterBottomSheetState extends State<AssetFilterBottomSheet> {
  final List<String> _selectedAssetTypes = [];
  String? _selectedPerformance;
  String? _selectedSortBy;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool get _hasActiveFilters =>
      _selectedAssetTypes.isNotEmpty ||
      _selectedPerformance != null ||
      _selectedSortBy != null ||
      _searchController.text.isNotEmpty;

  void _clearAllFilters() {
    setState(() {
      _selectedAssetTypes.clear();
      _selectedPerformance = null;
      _selectedSortBy = null;
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and close button
          _buildHeader(context),
          const SizedBox(height: 24),

          // Asset Type Filter Section
          _buildAssetTypeSection(context),
          const SizedBox(height: 24),

          // Performance Filter Section
          _buildPerformanceSection(context),
          const SizedBox(height: 24),

          // Sort By Section
          _buildSortBySection(context),
          const SizedBox(height: 24),

          // Keyword Search Section
          _buildKeywordSearchSection(context),
          const SizedBox(height: 24),

          // Apply Button
          _buildApplyButton(context),

          // Keyboard padding
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppText.large(
          'Filter',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.primaryText(context),
            fontSize: 22,
          ),
        ),
        Row(
          children: [
            if (_hasActiveFilters)
              GestureDetector(
                onTap: _clearAllFilters,
                child: AppText.small('Clear All', color: AppColors.appPrimary),
              ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.cancel,
                size: 22,
                color: AppColors.secondaryText(context),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAssetTypeSection(BuildContext context) {
    final assetTypes = [
      'All',
      'Stocks',
      'Mutual Funds',
      'T-Bills',
      'Bonds',
      'REITs',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.small('Asset Type', color: AppColors.primaryText(context)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: assetTypes.map((type) {
            return _buildMultiSelectChip(type, _selectedAssetTypes, (value) {
              setState(() {
                if (value == 'All') {
                  _selectedAssetTypes.clear();
                } else {
                  if (_selectedAssetTypes.contains(value)) {
                    _selectedAssetTypes.remove(value);
                  } else {
                    _selectedAssetTypes.add(value);
                  }
                }
              });
            });
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPerformanceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.small('Performance', color: AppColors.secondaryText(context)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildStatusChip(
              'Positive',
              AppColors.activitySuccess,
              AppColors.activitySuccessLight,
              _selectedPerformance,
              (value) => setState(() => _selectedPerformance = value),
            ),
            _buildStatusChip(
              'Negative',
              AppColors.activityError,
              AppColors.activityErrorLight,
              _selectedPerformance,
              (value) => setState(() => _selectedPerformance = value),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSortBySection(BuildContext context) {
    final sortOptions = [
      'Value (High to Low)',
      'Value (Low to High)',
      'Change % (High to Low)',
      'Change % (Low to High)',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.small('Sort By', color: AppColors.secondaryText(context)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: sortOptions.map((option) {
            return _buildFilterChip(
              option,
              _selectedSortBy,
              (value) => setState(() => _selectedSortBy = value),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildKeywordSearchSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.small('Search', color: AppColors.secondaryText(context)),
        const SizedBox(height: 12),
        MulaTextField(
          controller: _searchController,
          hintText: 'Search by asset name',
          filled: true,
          fillColor: AppColors.offWhite(context),
        ),
      ],
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return AppButton(
      text: 'Apply',
      backgroundColor: AppColors.appPrimary,
      textColor: Colors.white,
      borderRadius: 8,
      padding: EdgeInsets.zero,
      onTap: () {
        // TODO: Apply filters and update holdings list
        Navigator.pop(context);
      },
    );
  }

  Widget _buildFilterChip(
    String label,
    String? selectedValue,
    Function(String?) onTap,
  ) {
    final isSelected = selectedValue == label;
    return GestureDetector(
      onTap: () => onTap(isSelected ? null : label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.appPrimary.withValues(alpha: 0.1)
              : AppColors.offWhite(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 0.6,
            color: isSelected ? AppColors.appPrimary : Colors.transparent,
          ),
        ),
        child: AppText.smallest(
          label,
          color: isSelected
              ? AppColors.appPrimary
              : AppColors.primaryText(context),
        ),
      ),
    );
  }

  Widget _buildMultiSelectChip(
    String label,
    List<String> selectedValues,
    Function(String) onTap,
  ) {
    final isSelected = label == 'All'
        ? selectedValues.isEmpty
        : selectedValues.contains(label);

    return GestureDetector(
      onTap: () => onTap(label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.appPrimary.withValues(alpha: 0.1)
              : AppColors.offWhite(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 0.6,
            color: isSelected ? AppColors.appPrimary : Colors.transparent,
          ),
        ),
        child: AppText.smallest(
          label,
          color: isSelected
              ? AppColors.appPrimary
              : AppColors.primaryText(context),
        ),
      ),
    );
  }

  Widget _buildStatusChip(
    String label,
    Color textColor,
    Color bgColor,
    String? selectedValue,
    Function(String?) onTap,
  ) {
    final isSelected = selectedValue == label;
    return GestureDetector(
      onTap: () => onTap(isSelected ? null : label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? textColor : Colors.transparent,
            width: isSelected ? 0.6 : 0,
          ),
        ),
        child: AppText.smallest(
          label,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
