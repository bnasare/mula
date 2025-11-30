import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/category_filter_tabs.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../../shared/presentation/screens/asset_search_screen.dart';
import '../widgets/coming_soon_content.dart';
import '../widgets/ghana_stocks_content.dart';

/// Explore tab - Browse and discover investment opportunities
class ExploreTab extends StatefulWidget {
  const ExploreTab({super.key});

  @override
  State<ExploreTab> createState() => _ExploreTabState();
}

class _ExploreTabState extends State<ExploreTab> {
  String _selectedCategory = 'ghanaStocks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.exploreInvestments,
        centerTitle: false,
        showBackButton: false,
        actions: [
          IconButton(
            icon: Icon(
              IconlyLight.search,
              color: AppColors.primaryText(context),
            ),
            onPressed: () {
              NavigationHelper.navigateTo(context, const AssetSearchScreen());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          AppSpacer.vLarge(),
          // Filter tabs
          CategoryFilterTabs(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() {
                _selectedCategory = category;
              });
            },
            categories: [
              CategoryItem(
                key: 'ghanaStocks',
                label: context.localize.ghanaStocks,
              ),
              CategoryItem(
                key: 'tBillsBonds',
                label: context.localize.tBillsBonds,
              ),
              CategoryItem(
                key: 'mutualFunds',
                label: context.localize.mutualFunds,
              ),
              CategoryItem(key: 'featured', label: context.localize.featured),
            ],
          ),
          AppSpacer.vLarge(),
          // Content based on selected tab
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedCategory) {
      case 'ghanaStocks':
        return const GhanaStocksContent();
      case 'tBillsBonds':
        return const SizedBox.shrink();
      case 'mutualFunds':
        return const SizedBox.shrink();
      case 'featured':
        return const ComingSoonContent();
      default:
        return const SizedBox.shrink();
    }
  }
}
