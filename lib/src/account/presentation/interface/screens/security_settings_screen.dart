import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mula/shared/utils/localization_extension.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../widgets/session_card.dart';
import '../widgets/settings_list_tile.dart';
import '../widgets/settings_section.dart';
import 'biometric_settings_screen.dart';
import 'change_password_screen.dart';

class SecuritySession {
  final String deviceName;
  final String location;
  final String ipAddress;
  final DateTime timestamp;
  final bool isActive;
  final String deviceType;

  SecuritySession({
    required this.deviceName,
    required this.location,
    required this.ipAddress,
    required this.timestamp,
    required this.isActive,
    this.deviceType = 'mobile',
  });

  String getFormattedTimestamp() {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      final day = timestamp.day.toString().padLeft(2, '0');
      final month = timestamp.month.toString().padLeft(2, '0');
      final year = timestamp.year.toString().substring(2);
      return '$day/$month/$year • ${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}${timestamp.hour >= 12 ? 'PM' : 'AM'}';
    }
  }

  static List<SecuritySession> getMockCurrentSessions() {
    final now = DateTime.now();
    return [
      SecuritySession(
        deviceName: 'Samsung A15',
        location: 'Accra, Ghana',
        ipAddress: '192.168.1.45',
        timestamp: now,
        isActive: true,
        deviceType: 'mobile',
      ),
    ];
  }

  static List<SecuritySession> getMockPastSessions() {
    final now = DateTime.now();
    return [
      SecuritySession(
        deviceName: 'Samsung A15',
        location: 'Tema, Ghana',
        ipAddress: '192.168.0.234',
        timestamp: now.subtract(const Duration(days: 1, hours: 5)),
        isActive: false,
        deviceType: 'mobile',
      ),
      SecuritySession(
        deviceName: 'MacBook Pro',
        location: 'Accra, Ghana',
        ipAddress: '192.168.1.102',
        timestamp: now.subtract(const Duration(days: 2, hours: 10)),
        isActive: false,
        deviceType: 'desktop',
      ),
      SecuritySession(
        deviceName: 'iPad Air',
        location: 'Kumasi, Ghana',
        ipAddress: '10.0.0.156',
        timestamp: now.subtract(const Duration(days: 3, hours: 15)),
        isActive: false,
        deviceType: 'tablet',
      ),
    ];
  }
}

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  late List<SecuritySession> currentSessions;
  late List<SecuritySession> pastSessions;

  @override
  void initState() {
    super.initState();
    currentSessions = SecuritySession.getMockCurrentSessions();
    pastSessions = SecuritySession.getMockPastSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.securitySettings,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: context.responsivePadding(
          mobile: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Security Actions Section
            SettingsSection(
              title: context.localize.security,
              children: [
                SettingsListTile(
                  icon: Iconsax.lock,
                  title: context.localize.changePassword,
                  iconColor: AppColors.appPrimary,
                  onTap: () {
                    NavigationHelper.navigateTo(
                      context,
                      const ChangePasswordScreen(),
                    );
                  },
                ),
                const SizedBox(height: 8),
                SettingsListTile(
                  icon: Iconsax.finger_scan,
                  title: context.localize.biometricSettings,
                  iconColor: AppColors.info,
                  onTap: () {
                    NavigationHelper.navigateTo(
                      context,
                      const BiometricSettingsScreen(),
                    );
                  },
                ),
              ],
            ),

            const AppSpacer.vLarge(),

            // Activity Sessions Section
            SettingsSection(
              title: context.localize.activitySessions,
              children: [
                // Current Sessions
                AppText.smaller(
                  context.localize.currentSessions,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 12),
                ...currentSessions.map(
                  (session) => SessionCard(
                    deviceName: session.deviceName,
                    location: session.location,
                    ipAddress: session.ipAddress,
                    timestamp: session.getFormattedTimestamp(),
                    isActive: session.isActive,
                    deviceType: session.deviceType,
                  ),
                ),

                const SizedBox(height: 12),
                Divider(color: context.lightGreyColor),
                const SizedBox(height: 12),

                // Past Sessions
                AppText.smaller(
                  context.localize.pastSessions,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.primaryTextColor,
                  ),
                ),
                const SizedBox(height: 12),
                ...pastSessions.map(
                  (session) => SessionCard(
                    deviceName: session.deviceName,
                    location: session.location,
                    ipAddress: session.ipAddress,
                    timestamp: session.getFormattedTimestamp(),
                    isActive: session.isActive,
                    deviceType: session.deviceType,
                  ),
                ),
              ],
            ),

            const AppSpacer.vLarge(),
          ],
        ),
      ),
    );
  }
}
