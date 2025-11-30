import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() {
          _version = packageInfo.version;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _version = '1.1.0';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.aboutApp,
        showBottomDivider: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppSpacer.vLarge(),

                    // App Logo
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.appPrimary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.star_rounded,
                          color: AppColors.white(context),
                          size: 48,
                        ),
                      ),
                    ),

                    AppSpacer.vLarge(),

                    // Tagline
                    AppText.medium(
                      context.localize.aboutAppTagline,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: context.primaryTextColor,
                      ),
                    ),

                    AppSpacer.vLarge(),

                    // App Description
                    AppText.smaller(
                      context.localize.aboutAppDescription,
                      align: TextAlign.center,
                      style: TextStyle(
                        color: context.secondaryTextColor,
                        height: 1.5,
                      ),
                    ),

                    AppSpacer.vLarger(),

                    Divider(
                      color: context.secondaryTextColor.withValues(alpha: 0.2),
                    ),

                    AppSpacer.vLarge(),

                    // Our Mission Section
                    _buildSection(
                      context,
                      title: context.localize.aboutAppOurMission,
                      content: context.localize.aboutAppMissionDescription,
                    ),

                    AppSpacer.vLarge(),

                    Divider(
                      color: context.secondaryTextColor.withValues(alpha: 0.2),
                    ),

                    AppSpacer.vLarge(),

                    // Our Values Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.medium(
                          context.localize.aboutAppOurValues,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: context.primaryTextColor,
                          ),
                        ),
                        _buildValueItem(
                          context,
                          context.localize.aboutAppValueTrust,
                          context.localize.aboutAppValueTrustDescription,
                        ),
                        _buildValueItem(
                          context,
                          context.localize.aboutAppValueClarity,
                          context.localize.aboutAppValueClarityDescription,
                        ),
                        _buildValueItem(
                          context,
                          context.localize.aboutAppValueGrowth,
                          context.localize.aboutAppValueGrowthDescription,
                        ),
                      ],
                    ),

                    AppSpacer.vLarger(),
                  ],
                ),
              ),
            ),

            // Version pinned at bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: AppText.smallest(
                'Version: $_version',
                style: TextStyle(color: context.secondaryTextColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.medium(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: context.primaryTextColor,
          ),
        ),
        AppSpacer.vShort(),
        AppText.smaller(
          content,
          style: TextStyle(color: context.secondaryTextColor, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildValueItem(
    BuildContext context,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.smaller(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.appPrimary,
            ),
          ),
          const SizedBox(height: 4),
          AppText.smaller(
            description,
            style: TextStyle(color: context.secondaryTextColor, height: 1.4),
          ),
        ],
      ),
    );
  }
}
