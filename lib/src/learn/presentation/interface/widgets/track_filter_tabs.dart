import 'package:flutter/material.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';

class TrackFilterTabs extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const TrackFilterTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'key': 'all', 'label': context.localize.allTracks},
      {'key': 'ghanaStocks', 'label': context.localize.ghanaStocks},
      {'key': 'tBillsBonds', 'label': context.localize.tBillsBonds},
      {'key': 'mutualFunds', 'label': context.localize.mutualFunds},
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category['key'];

          return GestureDetector(
            onTap: () => onCategorySelected(category['key'] as String),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.appPrimary
                    : AppColors.card(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.appPrimary
                      : AppColors.card(context),
                  width: 1,
                ),
              ),
              child: Center(
                child: AppText.smaller(
                  category['label'] as String,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : AppColors.primaryText(context),
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
