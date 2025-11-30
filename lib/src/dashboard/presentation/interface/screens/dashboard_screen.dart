import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../account/presentation/interface/screens/account_tab.dart';
import '../../../../explore/presentation/interface/screens/explore_tab.dart';
import '../../../../home/presentation/interface/screens/home_tab.dart';
import '../../../../learn/presentation/interface/screens/learn_tab.dart';
import '../../../../portfolio/presentation/interface/screens/portfolio_tab.dart';
import '../../provider/dashboard_provider.dart';
import '../widgets/custom_bottom_nav_bar.dart';

/// Main dashboard screen with bottom navigation
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().loadDefaultTab();
    });
  }

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
