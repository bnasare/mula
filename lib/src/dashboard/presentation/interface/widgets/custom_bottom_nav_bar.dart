import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../provider/dashboard_provider.dart';

/// Custom bottom navigation bar for the dashboard
class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();
    final currentIndex = provider.currentTabIndex;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card(context),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryText(context).withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 60,
          padding: context.responsivePadding(
            mobile: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavBarItem(
                iconLight: IconlyLight.home,
                iconBold: IconlyBold.home,
                label: context.localize.home,
                isActive: currentIndex == 0,
                onTap: () => provider.changeTab(0),
              ),
              _NavBarItem(
                iconLight: IconlyLight.discovery,
                iconBold: IconlyBold.discovery,
                label: context.localize.explore,
                isActive: currentIndex == 1,
                onTap: () => provider.changeTab(1),
              ),
              _NavBarItem(
                iconLight: IconlyLight.chart,
                iconBold: IconlyBold.chart,
                label: context.localize.portfolio,
                isActive: currentIndex == 2,
                onTap: () => provider.changeTab(2),
              ),
              _NavBarItem(
                iconLight: IconlyLight.document,
                iconBold: IconlyBold.document,
                label: context.localize.learn,
                isActive: currentIndex == 3,
                onTap: () => provider.changeTab(3),
              ),
              _NavBarItem(
                iconLight: IconlyLight.profile,
                iconBold: IconlyBold.profile,
                label: context.localize.account,
                isActive: currentIndex == 4,
                onTap: () => provider.changeTab(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Individual navigation bar item
class _NavBarItem extends StatelessWidget {
  final IconData iconLight;
  final IconData iconBold;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.iconLight,
    required this.iconBold,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? AppColors.appPrimary
        : AppColors.secondaryText(context);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isActive ? iconBold : iconLight, color: color, size: 20),
            const SizedBox(height: 4),
            AppText.smallest(label, color: color),
          ],
        ),
      ),
    );
  }
}
