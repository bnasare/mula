import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import 'constants/app_text.dart';

/// Model for category items in the filter tabs
class CategoryItem {
  final String key;
  final String label;

  const CategoryItem({required this.key, required this.label});
}

/// Reusable category filter tabs widget
/// Used in Learn tab and Explore tab for filtering content by category
class CategoryFilterTabs extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final List<CategoryItem> categories;

  const CategoryFilterTabs({
    super.key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        primary: false,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category.key;

          return GestureDetector(
            onTap: () => onCategorySelected(category.key),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.appPrimary
                    : AppColors.softBorder(context),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? AppColors.appPrimary
                      : AppColors.hardBorder(context),
                  width: 1,
                ),
              ),
              child: Center(
                child: AppText.smaller(
                  category.label,
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.white(context)
                        : AppColors.primaryText(context),
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
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
