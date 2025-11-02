import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/dashboard_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'account_tab.dart';
import 'explore_tab.dart';
import 'home_tab.dart';
import 'learn_tab.dart';
import 'portfolio_tab.dart';

/// Main dashboard screen with bottom navigation
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();

    return Scaffold(
      body: IndexedStack(
        index: provider.currentTabIndex,
        children: const [
          HomeTab(),
          ExploreTab(),
          PortfolioTab(),
          LearnTab(),
          AccountTab(),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(),
    );
  }
}
