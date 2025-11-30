import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/snackbar.dart';
import '../../../../../shared/services/preferences_service.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../widgets/notification_toggle_tile.dart';
import '../widgets/settings_section.dart';

class NotificationPreferencesScreen extends StatefulWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  State<NotificationPreferencesScreen> createState() =>
      _NotificationPreferencesScreenState();
}

class _NotificationPreferencesScreenState
    extends State<NotificationPreferencesScreen> {
  Map<String, bool> _preferences = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await PreferencesService.getAllNotificationPreferences();
      if (mounted) {
        setState(() {
          _preferences = prefs;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        SnackBarHelper.showErrorSnackBar(
          context,
          '${context.localize.errorLoadingPreferences}: $e',
        );
      }
    }
  }

  Future<void> _updatePreference(String key, bool value) async {
    // Update local state immediately for smooth UX
    setState(() {
      _preferences[key] = value;
    });

    // Persist to storage asynchronously
    try {
      await PreferencesService.saveNotificationPreference(key, value);
    } catch (e) {
      if (mounted) {
        SnackBarHelper.showErrorSnackBar(
          context,
          '${context.localize.errorSavingPreference}: $e',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.notificationPreferences,
        showBottomDivider: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description
                    AppText.smaller(
                      padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
                      context.localize.chooseNotifications,
                      style: TextStyle(color: context.secondaryTextColor),
                    ),
                    AppSpacer.vLarge(),

                    // Account Activity Section
                    SettingsSection(
                      title: context.localize.accountActivity,
                      children: [
                        NotificationToggleTile(
                          icon: Iconsax.wallet,
                          title: context.localize.depositsWithdrawalsNotif,
                          subtitle:
                              context.localize.depositsWithdrawalsNotifDesc,
                          iconColor: AppColors.appPrimary,
                          value: _preferences['deposits_withdrawals'] ?? true,
                          onChanged: (value) =>
                              _updatePreference('deposits_withdrawals', value),
                        ),
                        NotificationToggleTile(
                          icon: Iconsax.receipt_text,
                          title: context.localize.tradeConfirmationsNotif,
                          subtitle:
                              context.localize.tradeConfirmationsNotifDesc,
                          iconColor: AppColors.info,
                          value: _preferences['trade_confirmations'] ?? true,
                          onChanged: (value) =>
                              _updatePreference('trade_confirmations', value),
                        ),
                        NotificationToggleTile(
                          icon: Iconsax.shield_tick,
                          title: context.localize.securityAlertsNotif,
                          subtitle: context.localize.securityAlertsNotifDesc,
                          iconColor: AppColors.error,
                          value: _preferences['security_alerts'] ?? true,
                          onChanged: (value) =>
                              _updatePreference('security_alerts', value),
                        ),
                      ],
                    ),

                    AppSpacer.vLarge(),

                    // Market Updates Section
                    SettingsSection(
                      title: context.localize.marketUpdates,
                      children: [
                        NotificationToggleTile(
                          icon: Iconsax.chart,
                          title: context.localize.priceAlertsNotif,
                          subtitle: context.localize.priceAlertsNotifDesc,
                          iconColor: AppColors.appPrimary,
                          value: _preferences['price_alerts'] ?? true,
                          onChanged: (value) =>
                              _updatePreference('price_alerts', value),
                        ),
                        NotificationToggleTile(
                          icon: Iconsax.document_text,
                          title: context.localize.marketNewsNotif,
                          subtitle: context.localize.marketNewsNotifDesc,
                          iconColor: AppColors.warning,
                          value: _preferences['market_news'] ?? true,
                          onChanged: (value) =>
                              _updatePreference('market_news', value),
                        ),
                        NotificationToggleTile(
                          icon: Iconsax.trend_up,
                          title: context.localize.portfolioPerformanceNotif,
                          subtitle:
                              context.localize.portfolioPerformanceNotifDesc,
                          iconColor: AppColors.info,
                          value: _preferences['portfolio_performance'] ?? true,
                          onChanged: (value) =>
                              _updatePreference('portfolio_performance', value),
                        ),
                      ],
                    ),

                    AppSpacer.vLarge(),

                    // Educational Section
                    SettingsSection(
                      title: context.localize.educational,
                      children: [
                        NotificationToggleTile(
                          icon: Iconsax.book,
                          title: context.localize.learningRemindersNotif,
                          subtitle: context.localize.learningRemindersNotifDesc,
                          iconColor: AppColors.appPrimary,
                          value: _preferences['learning_reminders'] ?? true,
                          onChanged: (value) =>
                              _updatePreference('learning_reminders', value),
                        ),
                        NotificationToggleTile(
                          icon: Iconsax.note,
                          title: context.localize.newContentNotif,
                          subtitle: context.localize.newContentNotifDesc,
                          iconColor: AppColors.warning,
                          value: _preferences['new_content'] ?? true,
                          onChanged: (value) =>
                              _updatePreference('new_content', value),
                        ),
                      ],
                    ),

                    AppSpacer.vLarge(),
                  ],
                ),
              ),
            ),
    );
  }
}
