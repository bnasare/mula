import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../dashboard/presentation/interface/widgets/activity_list_item.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import '../widgets/export_bottom_sheet.dart';
import '../widgets/filter_bottom_sheet.dart';
import '../widgets/transaction_receipt_modal.dart';
import 'report_issue_screen.dart';

/// Full screen showing all transactions/activities
class TransactionsScreen extends StatelessWidget {
  final DashboardProvider dashboardProvider;

  const TransactionsScreen({
    super.key,
    required this.dashboardProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBarHelpers.withActions(
        title: context.localize.transactions,
        actions: [
          IconButton(
            icon: Icon(
              IconlyBold.filter,
              color: AppColors.primaryText(context),
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const FilterBottomSheet(),
              );
            },
          ),
          PopupMenuButton<String>(
            child: Icon(Icons.more_vert, color: AppColors.primaryText(context)),
            onSelected: (value) {
              if (value == 'export') {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (context) => const ExportBottomSheet(),
                );
              } else if (value == 'report') {
                NavigationHelper.navigateTo(context, const ReportIssueScreen());
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'export',
                child: AppText.small(
                  context.localize.export,
                  color: AppColors.primaryText(context),
                ),
              ),
              PopupMenuItem(
                value: 'report',
                child: AppText.small(
                  context.localize.reportAnIssue,
                  color: AppColors.primaryText(context),
                ),
              ),
            ],
          ),
        ],
      ),
      body: dashboardProvider.isLoadingActivities
          ? const Center(child: CircularProgressIndicator())
          : dashboardProvider.recentActivities.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        IconlyBold.document,
                        size: 64,
                        color: AppColors.secondaryText(context).withOpacity(0.3),
                      ),
                      const SizedBox(height: 16),
                      AppText.small(
                        context.localize.noTransactionsYet,
                        color: AppColors.secondaryText(context),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () => dashboardProvider.refresh(),
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    itemCount: dashboardProvider.recentActivities.length,
                    separatorBuilder: (context, index) =>
                        Divider(color: AppColors.border(context), height: 1),
                    itemBuilder: (context, index) {
                      final activity = dashboardProvider.recentActivities[index];
                      return ActivityListItem(
                        activity: activity,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) =>
                                TransactionReceiptModal(activity: activity),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
