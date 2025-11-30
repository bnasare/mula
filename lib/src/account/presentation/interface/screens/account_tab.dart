import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../../../../../core/api/locale_provider.dart';
import '../../../../../core/api/theme_mode_provider.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/confirmation_dialog.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_search_bar.dart';
import '../../../../../shared/presentation/widgets/restart_widget.dart';
import '../../../../../shared/services/preferences_service.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../dashboard/presentation/provider/dashboard_provider.dart';
import '../../../../linked_accounts/presentation/interface/screens/linked_accounts_screen.dart';
import '../mixins/profile_image_mixin.dart';
import '../widgets/profile_header.dart';
import '../widgets/settings_dropdown_tile.dart';
import '../widgets/settings_list_tile.dart';
import '../widgets/settings_section.dart';
import 'about_app_screen.dart';
import 'help_center_screen.dart';
import 'identification_screen.dart';
import 'learning_progress_screen.dart';
import 'notification_preferences_screen.dart';
import 'privacy_policy_screen.dart';
import 'profile_screen.dart';
import 'referral_screen.dart';
import 'security_settings_screen.dart';

class AccountTab extends StatefulWidget {
  const AccountTab({super.key});

  @override
  State<AccountTab> createState() => _AccountTabState();
}

enum HomePage { home, explore, portfolio, learn, account }

class _AccountTabState extends State<AccountTab> with ProfileImageMixin {
  String _selectedCurrency = 'GHS';
  HomePage _selectedHomePage = HomePage.home;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _currencies = ['GHS', 'USD', 'EUR', 'GBP'];

  String _getThemeModeLabel(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return context.localize.lightMode;
      case ThemeMode.dark:
        return context.localize.darkMode;
      case ThemeMode.system:
        return context.localize.system;
    }
  }

  AppThemeMode _themeToAppTheme(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return AppThemeMode.light;
      case ThemeMode.dark:
        return AppThemeMode.dark;
      case ThemeMode.system:
        return AppThemeMode.system;
    }
  }

  String _getHomePageLabel(BuildContext context, HomePage page) {
    switch (page) {
      case HomePage.home:
        return context.localize.home;
      case HomePage.explore:
        return context.localize.explore;
      case HomePage.portfolio:
        return context.localize.portfolio;
      case HomePage.learn:
        return context.localize.learn;
      case HomePage.account:
        return context.localize.account;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadDefaultHomePage();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserProfile();
    });
  }

  Future<void> _loadDefaultHomePage() async {
    final savedIndex = await PreferencesService.getDefaultHomePage();
    if (savedIndex != null && mounted) {
      setState(() {
        _selectedHomePage = HomePage.values[savedIndex];
      });
    }
  }

  Future<void> _loadUserProfile() async {
    final dashboardProvider = context.read<DashboardProvider>();
    if (dashboardProvider.userProfile == null) {
      await dashboardProvider.loadUserProfile();
    }
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: context.localize.logOut,
        description: context.localize.areYouSureYouWantToLogOut,
        primaryButtonLabel: context.localize.logOut,
        secondaryButtonLabel: context.localize.cancel,
        onPrimaryAction: () {
          Navigator.pop(context);
          // TODO: Implement actual logout logic
        },
        onSecondaryAction: () => Navigator.pop(context),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  bool _matchesSearch(String title) {
    if (_searchQuery.isEmpty) return true;
    return title.toLowerCase().contains(_searchQuery.toLowerCase());
  }

  bool _hasAnyMatches(BuildContext context) {
    final allItems = [
      context.localize.personalInformation,
      context.localize.identificationCard,
      context.localize.linkedAccounts,
      context.localize.notificationPreferences,
      context.localize.learningProgress,
      context.localize.referral,
      context.localize.securitySettings,
      context.localize.privacyPolicy,
      context.localize.help,
      context.localize.aboutApp,
      context.localize.currency,
      context.localize.defaultHomePage,
      context.localize.language,
      context.localize.systemSettings,
    ];
    return allItems.any((item) => _matchesSearch(item));
  }

  List<Widget> _buildProfileSection(BuildContext context) {
    final items = <Widget>[];

    if (_matchesSearch(context.localize.personalInformation)) {
      items.add(
        SettingsListTile(
          icon: Iconsax.user,
          title: context.localize.personalInformation,
          iconColor: AppColors.appPrimary,
          onTap: () =>
              NavigationHelper.navigateTo(context, const ProfileScreen()),
        ),
      );
    }
    if (_matchesSearch(context.localize.identificationCard)) {
      items.add(
        SettingsListTile(
          icon: IconlyLight.document,
          title: context.localize.identificationCard,
          iconColor: AppColors.appPrimary,
          onTap: () => NavigationHelper.navigateTo(
            context,
            const IdentificationScreen(),
          ),
        ),
      );
    }
    if (_matchesSearch(context.localize.linkedAccounts)) {
      items.add(
        SettingsListTile(
          icon: Iconsax.link,
          title: context.localize.linkedAccounts,
          iconColor: AppColors.warning,
          onTap: () => NavigationHelper.navigateTo(
            context,
            const LinkedAccountsScreen(),
          ),
        ),
      );
    }
    if (_matchesSearch(context.localize.notificationPreferences)) {
      items.add(
        SettingsListTile(
          icon: IconlyLight.notification,
          title: context.localize.notificationPreferences,
          iconColor: AppColors.warning,
          onTap: () => NavigationHelper.navigateTo(
            context,
            const NotificationPreferencesScreen(),
          ),
        ),
      );
    }
    if (_matchesSearch(context.localize.learningProgress)) {
      items.add(
        SettingsListTile(
          icon: Iconsax.book_1,
          title: context.localize.learningProgress,
          iconColor: AppColors.appPrimary,
          onTap: () => NavigationHelper.navigateTo(
            context,
            const LearningProgressScreen(),
          ),
        ),
      );
    }
    if (_matchesSearch(context.localize.referral)) {
      items.add(
        SettingsListTile(
          icon: Iconsax.people,
          title: context.localize.referral,
          iconColor: AppColors.info,
          onTap: () =>
              NavigationHelper.navigateTo(context, const ReferralScreen()),
        ),
      );
    }

    if (items.isEmpty) return [];
    return [
      SettingsSection(title: context.localize.profile, children: items),
      const SizedBox(height: 24),
    ];
  }

  List<Widget> _buildSecuritySection(BuildContext context) {
    final items = <Widget>[];

    if (_matchesSearch(context.localize.securitySettings)) {
      items.add(
        SettingsListTile(
          icon: Iconsax.lock,
          title: context.localize.securitySettings,
          iconColor: AppColors.error,
          onTap: () => NavigationHelper.navigateTo(
            context,
            const SecuritySettingsScreen(),
          ),
        ),
      );
    }

    if (items.isEmpty) return [];
    return [
      SettingsSection(title: context.localize.security, children: items),
      const SizedBox(height: 24),
    ];
  }

  List<Widget> _buildSettingsSection(
    BuildContext context,
    ThemeProvider themeProvider,
    LocaleProvider localeProvider,
    DashboardProvider dashboardProvider,
  ) {
    final items = <Widget>[];

    if (_matchesSearch(context.localize.privacyPolicy)) {
      items.add(
        SettingsListTile(
          icon: Iconsax.shield_tick,
          title: context.localize.privacyPolicy,
          iconColor: AppColors.info,
          onTap: () =>
              NavigationHelper.navigateTo(context, const PrivacyPolicyScreen()),
        ),
      );
    }
    if (_matchesSearch(context.localize.help)) {
      items.add(
        SettingsListTile(
          icon: Iconsax.message_question,
          title: context.localize.help,
          iconColor: AppColors.error,
          onTap: () =>
              NavigationHelper.navigateTo(context, const HelpCenterScreen()),
        ),
      );
    }
    if (_matchesSearch(context.localize.aboutApp)) {
      items.add(
        SettingsListTile(
          icon: Iconsax.info_circle,
          title: context.localize.aboutApp,
          iconColor: context.secondaryTextColor,
          onTap: () =>
              NavigationHelper.navigateTo(context, const AboutAppScreen()),
        ),
      );
    }
    if (_matchesSearch(context.localize.currency)) {
      items.add(
        SettingsDropdownTile<String>(
          icon: Iconsax.dollar_circle,
          title: context.localize.currency,
          iconColor: AppColors.appPrimary,
          value: _selectedCurrency,
          items: _currencies,
          onChanged: (value) {
            if (value != null) setState(() => _selectedCurrency = value);
          },
        ),
      );
    }
    if (_matchesSearch(context.localize.defaultHomePage)) {
      items.add(
        SettingsDropdownTile<HomePage>(
          icon: IconlyLight.home,
          title: context.localize.defaultHomePage,
          iconColor: AppColors.appPrimary,
          value: _selectedHomePage,
          items: HomePage.values,
          displayBuilder: (page) => _getHomePageLabel(context, page),
          onChanged: (value) async {
            if (value != null) {
              await dashboardProvider.saveAsDefaultHomePage(value.index);
              setState(() => _selectedHomePage = value);
            }
          },
        ),
      );
    }
    if (_matchesSearch(context.localize.language)) {
      items.add(
        SettingsDropdownTile<String>(
          icon: Iconsax.translate,
          title: context.localize.language,
          iconColor: AppColors.error,
          value: localeProvider.getCurrentLanguageName(),
          items: LocaleProvider.getSupportedLanguageNames(),
          onChanged: (value) async {
            if (value != null) {
              await localeProvider.setLocale(value);
              if (context.mounted) RestartWidget.restartApp(context);
            }
          },
        ),
      );
    }
    if (_matchesSearch(context.localize.systemSettings)) {
      items.add(
        SettingsDropdownTile<ThemeMode>(
          icon: themeProvider.themeMode == ThemeMode.dark
              ? Iconsax.moon
              : Iconsax.sun_1,
          title: context.localize.systemSettings,
          iconColor: AppColors.warning,
          value: themeProvider.themeMode,
          items: ThemeMode.values,
          displayBuilder: (mode) => _getThemeModeLabel(context, mode),
          onChanged: (value) {
            if (value != null) themeProvider.setTheme(_themeToAppTheme(value));
          },
        ),
      );
    }

    if (items.isEmpty) return [];
    return [SettingsSection(title: context.localize.settings, children: items)];
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final dashboardProvider = Provider.of<DashboardProvider>(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(
              context,
            ).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: AppText.medium(
                      context.localize.userSettings,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: context.primaryTextColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ProfileHeader(
                    userName: dashboardProvider.userProfile?['name'] ?? 'User',
                    profileImageFile: localProfileImage,
                    profileImageUrl:
                        dashboardProvider.userProfile?['profileImage'],
                    onLogout: () => _showLogoutConfirmation(context),
                    onProfileImageTap: handleProfileImageTap,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: MulaSearchBar(
                      hintText: context.localize.search,
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  ..._buildProfileSection(context),
                  ..._buildSecuritySection(context),
                  ..._buildSettingsSection(
                    context,
                    themeProvider,
                    localeProvider,
                    dashboardProvider,
                  ),
                  if (_searchQuery.isNotEmpty && !_hasAnyMatches(context))
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: AppText.medium(
                          context.localize.noResultsFound,
                          color: context.secondaryTextColor,
                        ),
                      ),
                    ),
                  AppSpacer.vLarger(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
