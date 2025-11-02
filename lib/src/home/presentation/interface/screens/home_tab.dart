import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/data/image_assets.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import '../../../../mula_bot/presentation/interface/screens/mula_bot_welcome_screen.dart';
import '../widgets/action_buttons_section.dart';
import '../widgets/asset_overview_section.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/learning_corner_section.dart';
import '../widgets/portfolio_section.dart';
import '../widgets/recent_activities_section.dart';

/// Home tab showing portfolio overview and recent activities
class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    // Load dashboard data when tab is first opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().loadDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => context.read<DashboardProvider>().refresh(),
        child: CustomScrollView(
          slivers: [
            // App bar with user greeting
            const HomeAppBar(),

            // Main content
            SliverToBoxAdapter(
              child: Padding(
                padding: context.responsivePadding(
                  mobile: const EdgeInsets.symmetric(horizontal: 24.0),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24),

                    // Portfolio value card
                    PortfolioSection(),
                    SizedBox(height: 24),

                    // Action buttons
                    ActionButtonsSection(),
                    SizedBox(height: 24),

                    // Learning corner
                    LearningCornerSection(),
                    SizedBox(height: 32),

                    // Asset overview
                    AssetOverviewSection(),
                    SizedBox(height: 32),

                    // Recent activities
                    RecentActivitiesSection(),
                    SizedBox(height: 100), // Space for bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          NavigationHelper.navigateTo(context, const MulaBotWelcomeScreen());
        },
        child: Image.asset(ImageAssets.ai, width: 64, height: 64),
      ),
    );
  }
}
