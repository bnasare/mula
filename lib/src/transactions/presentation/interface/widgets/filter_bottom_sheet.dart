import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
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
              AppText.large('Filter', color: AppColors.primaryText(context)),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Date Range
          AppText.small('Date Range', color: AppColors.secondaryText(context)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip('Last 30 days', _selectedDateRange, (value) {
                setState(() => _selectedDateRange = value);
              }),
              _buildFilterChip('Last 60 days', _selectedDateRange, (value) {
                setState(() => _selectedDateRange = value);
              }),
              _buildFilterChip('This Year', _selectedDateRange, (value) {
                setState(() => _selectedDateRange = value);
              }),
              _buildFilterChip('Custom Date', _selectedDateRange, (value) {
                setState(() => _selectedDateRange = value);
              }),
            ],
          ),
          const SizedBox(height: 24),

          // Sort by
          AppText.small('Sort by', color: AppColors.secondaryText(context)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterChip('All', _selectedSortBy, (value) {
                setState(() => _selectedSortBy = value);
              }),
              _buildFilterChip('Buy', _selectedSortBy, (value) {
                setState(() => _selectedSortBy = value);
              }),
              _buildFilterChip('Sell', _selectedSortBy, (value) {
                setState(() => _selectedSortBy = value);
              }),
              _buildFilterChip('Deposit', _selectedSortBy, (value) {
                setState(() => _selectedSortBy = value);
              }),
              _buildFilterChip('Withdraw', _selectedSortBy, (value) {
                setState(() => _selectedSortBy = value);
              }),
              _buildFilterChip('Transfer', _selectedSortBy, (value) {
                setState(() => _selectedSortBy = value);
              }),
            ],
          ),
          const SizedBox(height: 24),

          // Sort by Status
          AppText.small(
            'Sort by Status',
            color: AppColors.secondaryText(context),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildStatusChip(
                'Completed',
                const Color(0xFF4CAF50),
                const Color(0xFFE8F5E9),
                _selectedStatus,
                (value) {
                  setState(() => _selectedStatus = value);
                },
              ),
              _buildStatusChip(
                'Pending',
                const Color(0xFF9C27B0),
                const Color(0xFFF3E5F5),
                _selectedStatus,
                (value) {
                  setState(() => _selectedStatus = value);
                },
              ),
              _buildStatusChip(
                'Cancelled',
                const Color(0xFFEF5350),
                const Color(0xFFFFEBEE),
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
            'Keyword Search',
            color: AppColors.secondaryText(context),
          ),
          const SizedBox(height: 12),
          MulaTextField(
            controller: _searchController,
            hintText: 'Enter a keyword',
            filled: true,
            fillColor: AppColors.offWhite(context),
          ),
          const SizedBox(height: 24),

          // Apply Button
          AppButton(
            text: 'Apply',
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
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
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
            width: isSelected ? 2 : 0,
          ),
        ),
        child: AppText.smallest(label, color: textColor),
      ),
    );
  }
}
