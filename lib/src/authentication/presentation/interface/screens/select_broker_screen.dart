import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/confetti_success_screen.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../widgets/tasty_pad_text_field.dart';

class Broker {
  final String id;
  final String name;
  final String? logoAsset;

  const Broker({required this.id, required this.name, this.logoAsset});
}

class SelectBrokerScreen extends StatefulWidget {
  const SelectBrokerScreen({super.key});

  @override
  State<SelectBrokerScreen> createState() => _SelectBrokerScreenState();
}

class _SelectBrokerScreenState extends State<SelectBrokerScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // List of brokers
  static const List<Broker> _allBrokers = [
    Broker(id: 'ic_securities', name: 'IC Securities'),
    Broker(id: 'databank', name: 'Databank Investments'),
    Broker(id: 'cidan', name: 'Cidan Investments Limited'),
    Broker(id: 'crystal', name: 'Crystal Capital & Investment'),
    Broker(id: 'ecocapital', name: 'EcoCapital Investment Management Limited'),
    Broker(id: 'edc', name: 'EDC Investments Limited'),
    Broker(id: 'first_finance', name: 'First Finance Company Ltd'),
    Broker(id: 'glico', name: 'GLICO Capital Limited'),
    Broker(id: 'igs', name: 'IGS Financial Services Limited'),
    Broker(id: 'investcorp', name: 'InvestCorp Fund Managers Ltd'),
    Broker(id: 'nimed', name: 'Nimed Capital LTD'),
  ];

  List<Broker> get _filteredBrokers {
    if (_searchQuery.isEmpty) {
      return _allBrokers;
    }
    return _allBrokers
        .where(
          (broker) =>
              broker.name.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onBrokerSelected(Broker broker) {
    NavigationHelper.navigateTo(
      context,
      ConfettiSuccessScreen(
        title: context.localize.accountDetailsSuccessfullySubmitted,
        description: context.localize.accountDetailsSuccessDescription,
        primaryButtonText: context.localize.done,
        onPrimaryButtonTap: () {
          // Do nothing - just stays on success screen
        },
        secondaryButtonText: context.localize.addAnother,
        onSecondaryButtonTap: () {
          Navigator.pop(context); // Go back to broker selection
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: MulaAppBarHelpers.withProgress(
          title: context.localize.brokers,
          currentStep: 6,
          totalSteps: 11,
          progressColor: AppColors.appPrimary.withValues(alpha: 0.7),
          onBackPressed: () => Navigator.pop(context),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Description
              Padding(
                padding: context.responsivePadding(
                  mobile: const EdgeInsets.all(16.0),
                ),
                child: AppText.smaller(
                  context.localize.brokersDescription,
                  color: AppColors.secondaryText(context),
                ),
              ),
              // Search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TastyPadTextField(
                  controller: _searchController,
                  hintText: context.localize.searchByAssetNameOrType,
                  suffixIcon: Icon(
                    IconlyLight.search,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              const AppSpacer.vShort(),
              // Brokers list
              Expanded(
                child: _filteredBrokers.isEmpty
                    ? Center(
                        child: AppText.small(
                          context.localize.noBrokersFound,
                          color: AppColors.secondaryText(context),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: _filteredBrokers.length,
                        itemBuilder: (context, index) {
                          final broker = _filteredBrokers[index];
                          return _BrokerCard(
                            broker: broker,
                            onTap: () => _onBrokerSelected(broker),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrokerCard extends StatelessWidget {
  final Broker broker;
  final VoidCallback onTap;

  const _BrokerCard({required this.broker, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.lightGrey(context), width: 1),
        ),
        child: Row(
          children: [
            // Logo placeholder
            Container(
              width: 40,
              height: 40,
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
                      child: AppText.smaller(
                        broker.name.substring(0, 1).toUpperCase(),
                      ),
                    ),
            ),
            const AppSpacer.hShort(),
            // Broker name
            Expanded(
              child: AppText.smaller(
                broker.name,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
            ),
            AppSpacer.hShorter(),
            // Chevron icon
            Icon(Icons.chevron_right, color: Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
