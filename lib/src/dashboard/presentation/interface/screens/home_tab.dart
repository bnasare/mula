import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../deposit/presentation/interface/screens/deposit_account_selection_screen.dart';
import '../../../../withdraw/presentation/interface/screens/withdraw_account_selection_screen.dart';
import '../../provider/dashboard_provider.dart';
import '../widgets/action_button.dart';
import '../widgets/activity_list_item.dart';
import '../widgets/asset_donut_chart.dart';
import '../widgets/learning_corner_card.dart';
import '../widgets/portfolio_value_card.dart';

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
      backgroundColor: AppColors.offWhite(context),
      body: RefreshIndicator(
        onRefresh: () => context.read<DashboardProvider>().refresh(),
        child: CustomScrollView(
          slivers: [
            // App bar with user greeting
            _buildAppBar(),

            // Main content
            SliverToBoxAdapter(
              child: Padding(
                padding: context.responsivePadding(
                  mobile: const EdgeInsets.symmetric(horizontal: 24.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Portfolio value card
                    _buildPortfolioSection(),
                    const SizedBox(height: 24),

                    // Action buttons
                    _buildActionButtons(),
                    const SizedBox(height: 24),

                    // Learning corner
                    _buildLearningCorner(),
                    const SizedBox(height: 32),

                    // Asset overview
                    _buildAssetOverview(),
                    const SizedBox(height: 32),

                    // Recent activities
                    _buildRecentActivities(),
                    const SizedBox(height: 100), // Space for bottom nav
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: AppColors.offWhite(context),
      elevation: 0,
      pinned: false,
      floating: true,
      expandedHeight: 80,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: context.responsivePadding(
              mobile: const EdgeInsets.symmetric(horizontal: 24.0),
            ),
            child: Consumer<DashboardProvider>(
              builder: (context, provider, _) {
                final userName = provider.userProfile?['name'] ?? 'User';

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // User greeting
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText.small(
                          'Welcome back👋',
                          color: AppColors.secondaryText(context),
                        ),
                        const SizedBox(height: 4),
                        AppText.medium(
                          userName,
                          color: AppColors.primaryText(context),
                        ),
                      ],
                    ),

                    // Notification icon
                    IconButton(
                      icon: Icon(
                        IconlyBold.notification,
                        color: AppColors.primaryText(context),
                      ),
                      onPressed: () {
                        // TODO: Navigate to notifications screen
                        // NavigationHelper.navigateTo(context, NotificationsScreen());
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPortfolioSection() {
    return Consumer<DashboardProvider>(
      builder: (context, provider, _) {
        if (provider.isLoadingPortfolio) {
          return _buildPortfolioShimmer();
        }

        if (provider.portfolioSummary == null) {
          return const SizedBox.shrink();
        }

        return PortfolioValueCard(
          portfolioSummary: provider.portfolioSummary!,
        );
      },
    );
  }

  Widget _buildPortfolioShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.secondaryText(context).withOpacity(0.1),
      highlightColor: AppColors.secondaryText(context).withOpacity(0.05),
      child: Column(
        children: [
          Container(
            height: 20,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ActionButton(
          icon: IconlyBold.wallet,
          label: context.localize.deposit,
          onTap: () {
            NavigationHelper.navigateTo(
              context,
              const DepositAccountSelectionScreen(),
            );
          },
        ),
        ActionButton(
          icon: IconlyBold.download,
          label: context.localize.withdraw,
          onTap: () {
            NavigationHelper.navigateTo(
              context,
              const WithdrawAccountSelectionScreen(),
            );
          },
        ),
        ActionButton(
          icon: IconlyBold.swap,
          label: context.localize.trade,
          onTap: () {
            // TODO: Navigate to trade screen
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.localize.comingSoon)),
            );
          },
        ),
        ActionButton(
          icon: IconlyBold.chart,
          label: 'View Portfolio',
          onTap: () {
            // Switch to portfolio tab
            context.read<DashboardProvider>().changeTab(2);
          },
        ),
      ],
    );
  }

  Widget _buildLearningCorner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium(
          context.localize.learningCorner,
          color: AppColors.primaryText(context),
        ),
        const SizedBox(height: 12),
        LearningCornerCard(
          title: context.localize.learningCorner,
          description: context.localize.learnHowBondsWork,
          onLearnMore: () {
            // TODO: Navigate to learning content
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(context.localize.comingSoon)),
            );
          },
        ),
      ],
    );
  }

  Widget _buildAssetOverview() {
    return Consumer<DashboardProvider>(
      builder: (context, provider, _) {
        if (provider.isLoadingPortfolio) {
          return _buildAssetOverviewShimmer();
        }

        if (provider.portfolioSummary == null ||
            provider.portfolioSummary!.assets.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.medium(
              context.localize.assetOverview,
              color: AppColors.primaryText(context),
            ),
            const SizedBox(height: 16),

            // Tab buttons (Class, Broker, Performance)
            Row(
              children: [
                _TabButton(label: context.localize.classLabel, isActive: true),
                const SizedBox(width: 8),
                _TabButton(label: context.localize.broker, isActive: false),
                const SizedBox(width: 8),
                _TabButton(label: context.localize.performance, isActive: false),
              ],
            ),
            const SizedBox(height: 16),

            // Donut chart
            AssetDonutChart(assets: provider.portfolioSummary!.assets),
          ],
        );
      },
    );
  }

  Widget _buildAssetOverviewShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.secondaryText(context).withOpacity(0.1),
      highlightColor: AppColors.secondaryText(context).withOpacity(0.05),
      child: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentActivities() {
    return Consumer<DashboardProvider>(
      builder: (context, provider, _) {
        if (provider.isLoadingActivities) {
          return _buildActivitiesShimmer();
        }

        if (provider.recentActivities.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText.medium(
                  context.localize.recentActivities,
                  color: AppColors.primaryText(context),
                ),
                TextButton(
                  onPressed: () {
                    // TODO: View all activities
                  },
                  child: AppText.small(
                    context.localize.viewAll,
                    color: AppColors.appPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Activities list
            ...provider.recentActivities.map(
              (activity) => ActivityListItem(
                activity: activity,
                onTap: () {
                  // TODO: Navigate to activity details
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildActivitiesShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.secondaryText(context).withOpacity(0.1),
      highlightColor: AppColors.secondaryText(context).withOpacity(0.05),
      child: Column(
        children: List.generate(
          3,
          (index) => Container(
            height: 80,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}

/// Tab button for asset overview section
class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;

  const _TabButton({
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.appPrimary.withOpacity(0.1)
            : Colors.transparent,
        border: Border.all(
          color: isActive ? AppColors.appPrimary : AppColors.border(context),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: AppText.smallest(
        label,
        color: isActive ? AppColors.appPrimary : AppColors.secondaryText(context),
      ),
    );
  }
}
