import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../dashboard/domain/entities/activity.dart';
import '../../../../dashboard/presentation/interface/widgets/activity_list_item.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import '../../../../deposit/presentation/interface/screens/deposit_account_selection_screen.dart';
import '../../../../transactions/presentation/interface/screens/transactions_screen.dart';
import '../../../../transactions/presentation/interface/widgets/transaction_receipt_modal.dart';
import '../../../../withdraw/presentation/interface/screens/withdraw_account_selection_screen.dart';
import '../widgets/balance_card.dart';

/// Cash Wallet screen showing balance and transactions
class CashWalletScreen extends StatefulWidget {
  final DashboardProvider dashboardProvider;

  const CashWalletScreen({super.key, required this.dashboardProvider});

  @override
  State<CashWalletScreen> createState() => _CashWalletScreenState();
}

class _CashWalletScreenState extends State<CashWalletScreen> {
  // Sample activities
  final List<Activity> _activities = [
    Activity(
      id: '1',
      title: 'CalBank Ltd',
      subtitle: 'Black Star Brokerage',
      amount: 2000.0,
      shares: '3,700 Shares',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      type: ActivityType.sell,
      status: ActivityStatus.pending,
    ),
    Activity(
      id: '2',
      title: 'Scancom PLC',
      subtitle: 'Databank Brokerage',
      amount: 1500.0,
      shares: '350 Shares',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      type: ActivityType.buy,
      status: ActivityStatus.completed,
    ),
    Activity(
      id: '3',
      title: 'Mobile Money',
      subtitle: 'MTN Wallet',
      amount: 500.0,
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      type: ActivityType.deposit,
      status: ActivityStatus.completed,
    ),
    Activity(
      id: '4',
      title: 'Mobile Money',
      subtitle: 'MTN Wallet',
      amount: 500.0,
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      type: ActivityType.deposit,
      status: ActivityStatus.completed,
    ),
  ];

  bool get _hasTransactions => _activities.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(title: context.localize.cashWallet, showBottomDivider: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),

            // Balance Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: BalanceCard(balance: 1098.00, label: context.localize.emergencyFunds),
            ),

            const SizedBox(height: 24),

            // Withdraw and Deposit Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: _buildActionButton(
                      context,
                      icon: IconlyLight.wallet,
                      label: context.localize.withdraw,
                      onTap: () {
                        NavigationHelper.navigateTo(
                          context,
                          const WithdrawAccountSelectionScreen(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildActionButton(
                      context,
                      icon: IconlyLight.send,
                      label: context.localize.deposit,
                      onTap: () {
                        NavigationHelper.navigateTo(
                          context,
                          const DepositAccountSelectionScreen(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Transactions Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.medium(
                    context.localize.transactions,
                    color: AppColors.primaryText(context),
                  ),
                  if (_hasTransactions)
                    GestureDetector(
                      onTap: () {
                        NavigationHelper.navigateTo(
                          context,
                          TransactionsScreen(
                            dashboardProvider: widget.dashboardProvider,
                          ),
                        );
                      },
                      child: AppText.smaller(
                        context.localize.viewAll,
                        color: AppColors.appPrimary,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Transactions List or Empty State
            _hasTransactions
                ? _buildTransactionsList(context)
                : _buildEmptyState(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.grey(context).withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border(context), width: 0.6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: AppColors.primaryText(context)),
            const SizedBox(width: 8),
            AppText.small(label, color: AppColors.primaryText(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsList(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      itemCount: _activities.length,
      separatorBuilder: (context, index) =>
          Divider(color: AppColors.border(context), height: 1),
      itemBuilder: (context, index) {
        final activity = _activities[index];
        return ActivityListItem(
          activity: activity,
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => TransactionReceiptModal(activity: activity),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              IconlyBold.document,
              size: 80,
              color: AppColors.secondaryText(context).withOpacity(0.3),
            ),
            const SizedBox(height: 24),
            AppText.medium(
              context.localize.youHaveNoTransactions,
              color: AppColors.secondaryText(context),
              align: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
