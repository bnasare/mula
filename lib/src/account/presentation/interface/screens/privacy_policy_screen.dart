import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.privacyPolicy,
        showBottomDivider: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Introduction
              AppText.smaller(
                'At Mula, your privacy is important to us. This Privacy Policy explains how we collect, use, disclose, and protect your information when you use our mobile application and related services (collectively, the "Services").',
                style: TextStyle(
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
              ),
              AppSpacer.vShort(),
              AppText.smaller(
                'By using Mula, you agree to the practices described in this policy. If you do not agree with the terms, please do not use the Services.',
                style: TextStyle(
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
              ),

              AppSpacer.vLarge(),

              // Section 1: Information We Collect
              _buildSectionHeader(context, 'Information We Collect'),
              AppSpacer.vShort(),
              _buildSubsection(
                context,
                'a. Personal Information',
                'When you register or use Mula, we may collect:',
              ),
              _buildBulletPoint(context, 'Full name'),
              _buildBulletPoint(context, 'Email address'),
              _buildBulletPoint(context, 'Phone number'),
              _buildBulletPoint(context, 'Date of birth'),
              _buildBulletPoint(
                context,
                'Government-issued ID (for KYC/AML compliance)',
              ),
              _buildBulletPoint(context, 'Bank account or payment information'),
              _buildBulletPoint(
                context,
                'Tax identification number (as required by law)',
              ),

              AppSpacer.vShort(),
              _buildSubsection(
                context,
                'b. Financial Information',
                'We collect data on your investments, trading activity, account balances, and linked financial accounts to provide our core services.',
              ),

              AppSpacer.vShort(),
              _buildSubsection(
                context,
                'c. Usage Data',
                'We may collect information about your interactions with the app, such as:',
              ),
              _buildBulletPoint(context, 'Device type and OS'),
              _buildBulletPoint(context, 'IP address'),
              _buildBulletPoint(context, 'App usage logs'),
              _buildBulletPoint(context, 'Referral URLs'),
              _buildBulletPoint(context, 'Time and date of access'),

              AppSpacer.vShort(),
              _buildSubsection(
                context,
                'd. Location Information',
                'With your permission, we may collect location data to comply with regulatory requirements and enhance security.',
              ),

              AppSpacer.vLarge(),

              // Section 2: How We Use Your Information
              _buildSectionHeader(context, 'How We Use Your Information'),
              AppSpacer.vShort(),
              AppText.smaller(
                'We use your information to:',
                style: TextStyle(
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
              ),
              _buildBulletPoint(
                context,
                'Provide you access to the app and Services',
              ),
              _buildBulletPoint(
                context,
                'Verify your identity and comply with regulatory requirements (KYC/AML)',
              ),
              _buildBulletPoint(
                context,
                'Process transactions and manage your investment portfolio',
              ),
              _buildBulletPoint(
                context,
                'Improve and personalize your user experience',
              ),
              _buildBulletPoint(
                context,
                'Communicate with you about your account and relevant updates',
              ),
              _buildBulletPoint(
                context,
                'Detect, prevent, and respond to fraud or other security issues',
              ),

              AppSpacer.vLarge(),

              // Section 3: Sharing of Information
              _buildSectionHeader(context, 'Sharing of Information'),
              AppSpacer.vShort(),
              AppText.smaller(
                'We may share your information with:',
                style: TextStyle(
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
              ),
              _buildBulletPoint(
                context,
                'Regulatory and compliance authorities, as required by law',
              ),
              _buildBulletPoint(
                context,
                'Financial service providers, such as payment processors and brokerage partners',
              ),
              _buildBulletPoint(
                context,
                'Service providers and contractors who help us operate and improve Mula (under strict confidentiality agreements)',
              ),
              _buildBulletPoint(
                context,
                'Affiliates or corporate partners, with whom we have joint ventures',
              ),
              _buildBulletPoint(
                context,
                'Legal entities, in response to lawful requests such as subpoenas or court orders',
              ),
              AppSpacer.vShort(),
              AppText.smaller(
                'We do not sell your personal information to third parties.',
                style: TextStyle(
                  color: context.primaryTextColor,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),

              AppSpacer.vLarge(),

              // Section 4: Data Security
              _buildSectionHeader(context, 'Data Security'),
              AppSpacer.vShort(),
              AppText.smaller(
                'We implement industry-standard security measures to protect your information, including:',
                style: TextStyle(
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
              ),
              _buildBulletPoint(
                context,
                'Encryption of data in transit and at rest',
              ),
              _buildBulletPoint(context, 'Secure authentication mechanisms'),
              _buildBulletPoint(
                context,
                'Regular security audits and monitoring',
              ),
              _buildBulletPoint(
                context,
                'Limited access controls to personal data',
              ),
              AppSpacer.vShort(),
              AppText.smaller(
                'However, no method of transmission over the internet is 100% secure. While we strive to protect your data, we cannot guarantee absolute security.',
                style: TextStyle(
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
              ),

              AppSpacer.vLarge(),

              // Section 5: Your Rights
              _buildSectionHeader(context, 'Your Rights'),
              AppSpacer.vShort(),
              AppText.smaller(
                'You have the right to:',
                style: TextStyle(
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
              ),
              _buildBulletPoint(
                context,
                'Access the personal information we hold about you',
              ),
              _buildBulletPoint(
                context,
                'Request corrections to inaccurate data',
              ),
              _buildBulletPoint(
                context,
                'Request deletion of your data (subject to legal and regulatory requirements)',
              ),
              _buildBulletPoint(
                context,
                'Opt-out of non-essential communications',
              ),
              _buildBulletPoint(context, 'Request data portability'),
              AppSpacer.vShort(),
              AppText.smaller(
                'To exercise these rights, please contact us at privacy@mula.app.',
                style: TextStyle(
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
              ),

              AppSpacer.vLarge(),

              // Section 6: Data Retention
              _buildSectionHeader(context, 'Data Retention'),
              AppSpacer.vShort(),
              AppText.smaller(
                'We retain your personal information for as long as necessary to provide our Services and comply with legal obligations. When you close your account, we may retain certain data as required by law or for legitimate business purposes.',
                style: TextStyle(
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
              ),

              AppSpacer.vLarge(),

              // Section 7: Updates to This Policy
              _buildSectionHeader(context, 'Updates to This Privacy Policy'),
              AppSpacer.vShort(),
              AppText.smaller(
                'We may update this Privacy Policy from time to time. When we make changes, we will notify you via email or through the app. The "Last Updated" date at the top of this policy reflects when changes were last made.',
                style: TextStyle(
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
              ),

              AppSpacer.vLarge(),

              // Section 8: Contact Us
              _buildSectionHeader(context, 'Contact Us'),
              AppSpacer.vShort(),
              AppText.smaller(
                'If you have questions or concerns about this Privacy Policy or our data practices, please contact us:',
                style: TextStyle(
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
              ),
              AppSpacer.vShort(),
              AppText.smaller(
                'Email: privacy@mula.app',
                style: TextStyle(
                  color: context.primaryTextColor,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              AppText.smaller(
                'Phone: +233 550 667 9012',
                style: TextStyle(
                  color: context.primaryTextColor,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),

              AppSpacer.vLarger(),

              // Last Updated
              Center(
                child: AppText.smallest(
                  'Last Updated: November 30, 2025',
                  style: TextStyle(color: context.secondaryTextColor),
                ),
              ),

              AppSpacer.vLarge(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return AppText.medium(
      title,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: context.primaryTextColor,
      ),
    );
  }

  Widget _buildSubsection(BuildContext context, String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText.smaller(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: context.primaryTextColor,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 4),
        AppText.smaller(
          content,
          style: TextStyle(color: context.secondaryTextColor, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.smaller(
            '• ',
            style: TextStyle(color: context.secondaryTextColor),
          ),
          Expanded(
            child: AppText.smaller(
              text,
              style: TextStyle(color: context.secondaryTextColor, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
