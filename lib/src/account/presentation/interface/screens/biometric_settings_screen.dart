import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../widgets/notification_toggle_tile.dart';
import '../widgets/settings_section.dart';

class BiometricSettingsScreen extends StatefulWidget {
  const BiometricSettingsScreen({super.key});

  @override
  State<BiometricSettingsScreen> createState() =>
      _BiometricSettingsScreenState();
}

class _BiometricSettingsScreenState extends State<BiometricSettingsScreen> {
  bool _biometricEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.biometricSettings,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.smaller(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ).copyWith(bottom: 0),
              'Use your biometric data to quickly and securely access your account',
              color: AppColors.secondaryText(context),
            ),
            const AppSpacer.vLarge(),
            SettingsSection(
              title: '',
              children: [
                NotificationToggleTile(
                  title: context.localize.faceId,
                  subtitle: context.localize.useFaceId,
                  icon: Iconsax.finger_scan,
                  iconColor: AppColors.appPrimary,
                  value: _biometricEnabled,
                  onChanged: (value) {
                    setState(() {
                      _biometricEnabled = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
