import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../authentication/presentation/interface/widgets/mula_text_field.dart';

/// Bottom sheet for filtering transactions
class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedDateRange;
  String? _selectedSortBy;
  String? _selectedStatus;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.large(
                context.localize.filter,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryText(context),
                  fontSize: 22,
                ),
              ),
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
          const SizedBox(height: 24),

          // Date Range
          AppText.small(
            context.localize.dateRange,
            color: AppColors.primaryText(context),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip(
                context.localize.last30Days,
                _selectedDateRange,
                (value) {
                  setState(() => _selectedDateRange = value);
                },
              ),
              _buildFilterChip(
                context.localize.last60Days,
                _selectedDateRange,
                (value) {
                  setState(() => _selectedDateRange = value);
                },
              ),
              _buildFilterChip(context.localize.thisYear, _selectedDateRange, (
                value,
              ) {
                setState(() => _selectedDateRange = value);
              }),
              _buildFilterChip(
                context.localize.customDate,
                _selectedDateRange,
                (value) {
                  setState(() => _selectedDateRange = value);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Sort by
          AppText.small(
            context.localize.sortBy,
            color: AppColors.secondaryText(context),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip(context.localize.all, _selectedSortBy, (value) {
                setState(() => _selectedSortBy = value);
              }),
              _buildFilterChip(context.localize.buy, _selectedSortBy, (value) {
                setState(() => _selectedSortBy = value);
              }),
              _buildFilterChip(context.localize.sell, _selectedSortBy, (value) {
                setState(() => _selectedSortBy = value);
              }),
              _buildFilterChip(context.localize.deposit, _selectedSortBy, (
                value,
              ) {
                setState(() => _selectedSortBy = value);
              }),
              _buildFilterChip(context.localize.withdraw, _selectedSortBy, (
                value,
              ) {
                setState(() => _selectedSortBy = value);
              }),
              _buildFilterChip(context.localize.transfer, _selectedSortBy, (
                value,
              ) {
                setState(() => _selectedSortBy = value);
              }),
            ],
          ),
          const SizedBox(height: 24),

          // Sort by Status
          AppText.small(
            context.localize.sortByStatus,
            color: AppColors.secondaryText(context),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildStatusChip(
                context.localize.completed,
                AppColors.activitySuccess,
                AppColors.activitySuccessLight,
                _selectedStatus,
                (value) {
                  setState(() => _selectedStatus = value);
                },
              ),
              _buildStatusChip(
                context.localize.pending,
                AppColors.activityPending,
                AppColors.activityPendingLight,
                _selectedStatus,
                (value) {
                  setState(() => _selectedStatus = value);
                },
              ),
              _buildStatusChip(
                context.localize.cancelled,
                AppColors.activityError,
                AppColors.activityErrorLight,
                _selectedStatus,
                (value) {
                  setState(() => _selectedStatus = value);
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Keyword Search
          AppText.small(
            context.localize.keywordSearch,
            color: AppColors.secondaryText(context),
          ),
          const SizedBox(height: 12),
          MulaTextField(
            controller: _searchController,
            hintText: context.localize.enterAKeyword,
            filled: true,
            fillColor: AppColors.offWhite(context),
          ),
          const SizedBox(height: 24),

          // Apply Button
          AppButton(
            text: context.localize.apply,
            backgroundColor: AppColors.appPrimary,
            textColor: Colors.white,
            borderRadius: 8,
            padding: EdgeInsets.zero,
            onTap: () {
              // TODO: Apply filters
              Navigator.pop(context);
            },
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
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
              ? AppColors.appPrimary.withOpacity(0.1)
              : AppColors.offWhite(context),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 0.6,
            color: isSelected ? AppColors.appPrimary : AppColors.transparent,
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
            color: isSelected ? textColor : AppColors.transparent,
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
