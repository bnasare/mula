import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../widgets/tasty_pad_text_field.dart';
import 'fund_manager_details_screen.dart';
import 'fund_manager_login_screen.dart';

class FundManager {
  final String id;
  final String name;
  final String? logoAsset;

  const FundManager({required this.id, required this.name, this.logoAsset});
}

class SelectFundManagerScreen extends StatefulWidget {
  final bool isCreateAccountFlow;
  final bool fromLinkedAccounts;

  const SelectFundManagerScreen({
    super.key,
    this.isCreateAccountFlow = false,
    this.fromLinkedAccounts = false,
  });

  @override
  State<SelectFundManagerScreen> createState() =>
      _SelectFundManagerScreenState();
}

class _SelectFundManagerScreenState extends State<SelectFundManagerScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // List of fund managers
  static const List<FundManager> _allFundManagers = [
    FundManager(id: 'ashfield', name: 'Ashfield Investment Managers LTD'),
    FundManager(id: 'brassica', name: 'Brassica Capital Limited'),
    FundManager(id: 'cidan', name: 'Cidan Investments Limited'),
    FundManager(id: 'crystal', name: 'Crystal Capital & Investment'),
    FundManager(id: 'databank', name: 'Databank Asset Management Services LTD'),
    FundManager(
      id: 'ecocapital',
      name: 'EcoCapital Investment Management Limited',
    ),
    FundManager(id: 'edc', name: 'EDC Investments Limited'),
    FundManager(id: 'first_finance', name: 'First Finance Company Ltd'),
    FundManager(id: 'glico', name: 'GLICO Capital Limited'),
    FundManager(id: 'igs', name: 'IGS Financial Services Limited'),
    FundManager(id: 'investcorp', name: 'InvestCorp Asset Management'),
    FundManager(id: 'investiture', name: 'Investiture Fund Managers Ltd'),
    FundManager(id: 'nimed', name: 'Nimed Capital LTD'),
  ];

  List<FundManager> get _filteredFundManagers {
    if (_searchQuery.isEmpty) {
      return _allFundManagers;
    }
    return _allFundManagers
        .where(
          (manager) =>
              manager.name.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onFundManagerSelected(FundManager manager) {
    if (widget.isCreateAccountFlow) {
      // Create account flow - go to details screen
      NavigationHelper.navigateTo(
        context,
        FundManagerDetailsScreen(
          fundManager: manager,
          isCreateAccountFlow: true,
        ),
      );
    } else {
      // Link account flow - go to login screen
      NavigationHelper.navigateTo(
        context,
        FundManagerLoginScreen.cisFundManager(
          fundManager: manager,
          fromLinkedAccounts: widget.fromLinkedAccounts,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: widget.fromLinkedAccounts
            ? MulaAppBarHelpers.simple(
                title: context.localize.selectFundManager,
                onBackPressed: () => Navigator.pop(context),
              )
            : MulaAppBarHelpers.withProgress(
                title: context.localize.selectFundManager,
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
              if (!widget.fromLinkedAccounts)
                Padding(
                  padding: context.responsivePadding(
                    mobile: const EdgeInsets.all(16.0),
                  ),
                  child: AppText.smaller(
                    context.localize.selectFundManagerDescription,
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
                    color: AppColors.hintText(context),
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
              // Fund managers list
              Expanded(
                child: _filteredFundManagers.isEmpty
                    ? Center(
                        child: AppText.small(
                          'No fund managers found',
                          color: AppColors.secondaryText(context),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        itemCount: _filteredFundManagers.length,
                        itemBuilder: (context, index) {
                          final manager = _filteredFundManagers[index];
                          return _FundManagerCard(
                            manager: manager,
                            onTap: () => _onFundManagerSelected(manager),
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

class _FundManagerCard extends StatelessWidget {
  final FundManager manager;
  final VoidCallback onTap;

  const _FundManagerCard({required this.manager, required this.onTap});

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
              child: manager.logoAsset != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(manager.logoAsset!, fit: BoxFit.cover),
                    )
                  : Center(
                      child: AppText.smaller(
                        manager.name.substring(0, 1).toUpperCase(),
                      ),
                    ),
            ),
            const AppSpacer.hShort(),
            // Fund manager name
            Expanded(
              child: AppText.smaller(
                manager.name,
                style: TextStyle(overflow: TextOverflow.ellipsis),
                maxLines: 2,
              ),
            ),
            AppSpacer.hShorter(),
            // Chevron icon
            Icon(Icons.chevron_right, color: AppColors.hintText(context)),
          ],
        ),
      ),
    );
  }
}
