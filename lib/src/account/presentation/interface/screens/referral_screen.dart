import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/snackbar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../widgets/referral_history_tile.dart';
import '../widgets/referral_info_bottom_sheet.dart';
import '../widgets/referral_points_card.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  // Mock data - replace with actual data from API
  final String _referralCode = 'MULA3X7P';
  final int _points = 1280;
  final int _invites = 12;

  final List<_ReferralData> _pastReferrals = [
    _ReferralData(
      name: 'Amelia Gilmore',
      dateTime: '12th July 2025 • 5:00PM',
      pointsEarned: 50,
      avatarColor: AppColors.appPrimary,
    ),
    _ReferralData(
      name: 'Luke Danes',
      dateTime: '12th July 2025 • 5:00PM',
      pointsEarned: 50,
      avatarColor: AppColors.chartOrange,
    ),
    _ReferralData(
      name: 'Thomas Jefferson',
      dateTime: '12th July 2025 • 5:00PM',
      pointsEarned: 50,
      avatarColor: AppColors.chartGreen,
    ),
    _ReferralData(
      name: 'Jess Moriano',
      dateTime: '12th July 2025 • 5:00PM',
      pointsEarned: 50,
      avatarColor: AppColors.info,
    ),
    _ReferralData(
      name: 'Agnes Danes',
      dateTime: '12th July 2025 • 5:00PM',
      pointsEarned: 50,
      avatarColor: AppColors.appPrimary,
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkFirstTimeUser();
    });
  }

  Future<void> _checkFirstTimeUser() async {
    final prefs = await SharedPreferences.getInstance();
    final hasSeenReferralInfo = prefs.getBool('hasSeenReferralInfo') ?? false;

    if (!hasSeenReferralInfo && mounted) {
      await ReferralInfoBottomSheet.show(context, _referralCode);
      await prefs.setBool('hasSeenReferralInfo', true);
    }
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _referralCode));
    SnackBarHelper.showSuccessSnackBar(
      context,
      context.localize.copiedToClipboard,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.referral,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gift box placeholder
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.purple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Icon(
                  Iconsax.gift,
                  size: 60,
                  color: AppColors.purple,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Title and subtitle
            Center(
              child: Column(
                children: [
                  AppText.large(
                    context.localize.referralProgram,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryText(context),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Divider(
                    color: AppColors.border(context),
                    indent: 60,
                    endIndent: 60,
                  ),
                  const SizedBox(height: 8),
                  AppText.smaller(
                    context.localize.inviteFriendsEarnRewards,
                    color: AppColors.secondaryText(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Referral link section
            AppText.smaller(
              context.localize.referralLink,
              color: AppColors.secondaryText(context),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.card(context),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border(context)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: AppText.small(
                      _referralCode,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryText(context),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _copyToClipboard,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.lightGrey(context),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border(context)),
                      ),
                      child: Icon(
                        Iconsax.copy,
                        size: 18,
                        color: AppColors.primaryText(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Referral Points section
            AppText.smaller(
              context.localize.referralPoints,
              color: AppColors.secondaryText(context),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ReferralPointsCard(
                  label: context.localize.points,
                  value: _points.toString(),
                ),
                const SizedBox(width: 16),
                ReferralPointsCard(
                  label: context.localize.invites,
                  value: _invites.toString(),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Past Referrals section
            AppText.smaller(
              context.localize.pastReferrals,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.primaryText(context),
              ),
            ),
            const SizedBox(height: 16),

            // Referrals list
            ..._pastReferrals.map(
              (referral) => ReferralHistoryTile(
                name: referral.name,
                dateTime: referral.dateTime,
                pointsEarned: referral.pointsEarned,
                avatarColor: referral.avatarColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReferralData {
  final String name;
  final String dateTime;
  final int pointsEarned;
  final Color? avatarColor;

  _ReferralData({
    required this.name,
    required this.dateTime,
    required this.pointsEarned,
    this.avatarColor,
  });
}
