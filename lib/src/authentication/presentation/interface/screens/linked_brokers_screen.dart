import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import 'fund_manager_login_screen.dart';
import 'good_hands_info_screen.dart';

/// Model for broker information
class Broker {
  final String id;
  final String name;
  final String? logoAsset;

  const Broker({required this.id, required this.name, this.logoAsset});
}

class LinkedBrokersScreen extends StatefulWidget {
  final bool isFirstTime;
  final bool fromLinkedAccounts;

  const LinkedBrokersScreen({
    super.key,
    this.isFirstTime = true,
    this.fromLinkedAccounts = false,
  });

  @override
  State<LinkedBrokersScreen> createState() => _LinkedBrokersScreenState();
}

class _LinkedBrokersScreenState extends State<LinkedBrokersScreen> {
  // Track which brokers are connected using their IDs
  final Set<String> _connectedBrokerIds = {};

  // List of available brokers
  static const List<Broker> _brokers = [
    Broker(id: 'petra', name: 'PETRA'),
    Broker(id: 'ic_securities', name: 'IC Securities'),
    Broker(id: 'black_star', name: 'BLACK STAR'),
    Broker(id: 'databank', name: 'Databank'),
    Broker(id: 'apakan', name: 'Apakan'),
    Broker(id: 'constant_capital', name: 'Constant Capital'),
    Broker(id: 'laurus_africa', name: 'Laurus Africa'),
    Broker(id: 'sas_finance', name: 'SAS Finance Group'),
  ];

  void _onBrokerTap(Broker broker) {
    // Navigate to login screen for this broker
    NavigationHelper.navigateTo(
      context,
      FundManagerLoginScreen.csdBroker(
        broker: broker,
        fromLinkedAccounts: widget.fromLinkedAccounts,
        onAuthSuccess: () {
          // Mark broker as connected when returning from successful auth
          setState(() {
            _connectedBrokerIds.add(broker.id);
          });
        },
      ),
    );
  }

  void _onSkip() {
    // Navigate back to Link Investment Accounts screen
    NavigationHelper.navigateBack(context);
  }

  void _onAdd() {
    if (_connectedBrokerIds.isNotEmpty) {
      // Navigate to Good Hands Info screen from CSD flow (normal app bar, Continue button)
      NavigationHelper.navigateTo(context, const GoodHandsInfoScreen.fromCsd());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white(context),
      appBar: MulaAppBarHelpers.simple(
        backgroundColor: AppColors.white(context),
        title: context.localize.weFoundYourBrokers,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.responsivePadding(
            mobile: const EdgeInsets.all(16.0).copyWith(bottom: 0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description
              AppText.smaller(
                context.localize.signInToBrokersDescription,
                color: AppColors.secondaryText(context),
              ),
              const AppSpacer.vLarge(),
              // Brokers grid
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: _brokers.length,
                  itemBuilder: (context, index) {
                    final broker = _brokers[index];
                    final isConnected = _connectedBrokerIds.contains(broker.id);

                    return _BrokerCard(
                      broker: broker,
                      isConnected: isConnected,
                      onTap: () => _onBrokerTap(broker),
                    );
                  },
                ),
              ),
              const AppSpacer.vLarge(),
              // Buttons row - only show if not first time OR if brokers are connected
              if (!widget.isFirstTime || _connectedBrokerIds.isNotEmpty)
                Row(
                  children: [
                    // Skip button (flex: 1)
                    Expanded(
                      flex: 1,
                      child: AppButton(
                        text: context.localize.skip,
                        backgroundColor: AppColors.white(context),
                        textColor: AppColors.black(context),
                        borderRadius: 12,
                        padding: EdgeInsets.zero,
                        borderColor: AppColors.lightGrey(context),
                        onTap: _onSkip,
                      ),
                    ),
                    const AppSpacer.hShort(),
                    // Add button (flex: 2)
                    Expanded(
                      flex: 2,
                      child: AppButton(
                        text: context.localize.add,
                        backgroundColor: _connectedBrokerIds.isNotEmpty
                            ? AppColors.appPrimary
                            : AppColors.lightGrey(context),
                        textColor: _connectedBrokerIds.isNotEmpty
                            ? Colors.white
                            : AppColors.secondaryText(context),
                        borderRadius: 12,
                        padding: EdgeInsets.zero,
                        onTap: _connectedBrokerIds.isNotEmpty ? _onAdd : null,
                      ),
                    ),
                  ],
                ),
              if (!widget.isFirstTime || _connectedBrokerIds.isNotEmpty)
                const AppSpacer.vLarge(),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget for individual broker card
class _BrokerCard extends StatelessWidget {
  final Broker broker;
  final bool isConnected;
  final VoidCallback onTap;

  const _BrokerCard({
    required this.broker,
    required this.isConnected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isConnected
                ? AppColors.appPrimary
                : AppColors.lightGrey(context),
            width: isConnected ? 0.6 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo placeholder
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.lightGrey(context),
                borderRadius: BorderRadius.circular(8),
              ),
              child: broker.logoAsset != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(broker.logoAsset!, fit: BoxFit.cover),
                    )
                  : Center(
                      child: AppText.medium(
                        broker.name.substring(0, 1).toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
            const AppSpacer.vShort(),
            // Broker name
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: AppText.smaller(
                broker.name,
                align: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w400),
                maxLines: 2,
                clipped: true,
              ),
            ),
            const AppSpacer.vLarger(),
            // Connection status
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: isConnected
                    ? AppColors.appPrimary.withOpacity(0.1)
                    : AppColors.appPrimary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isConnected)
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: AppColors.appPrimary,
                    )
                  else
                    Icon(
                      Icons.add_circle_outline,
                      size: 16,
                      color: AppColors.appPrimary,
                    ),
                  const SizedBox(width: 4),
                  AppText.smallest(
                    isConnected ? 'Connected' : 'Connect',
                    style: TextStyle(color: AppColors.appPrimary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
