import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

class SessionCard extends StatelessWidget {
  final String deviceName;
  final String location;
  final String ipAddress;
  final String timestamp;
  final bool isActive;
  final String deviceType;

  const SessionCard({
    super.key,
    required this.deviceName,
    required this.location,
    required this.ipAddress,
    required this.timestamp,
    required this.isActive,
    this.deviceType = 'mobile',
  });

  IconData _getDeviceIcon() {
    switch (deviceType) {
      case 'desktop':
        return Iconsax.monitor;
      case 'tablet':
        return Icons.tablet;
      default:
        return Iconsax.mobile;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Device icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.appPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getDeviceIcon(),
              size: 24,
              color: AppColors.appPrimary,
            ),
          ),
          const SizedBox(width: 12),

          // Session details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Device name and status badge row
                Row(
                  children: [
                    Expanded(
                      child: AppText.smaller(
                        deviceName,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: context.primaryTextColor,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppColors.green.withValues(alpha: 0.1)
                            : AppColors.grey(context).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: AppText.smallest(
                        isActive ? 'Success' : 'Ended',
                        style: TextStyle(
                          color: isActive
                              ? AppColors.green
                              : AppColors.secondaryText(context),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                // Location
                Row(
                  children: [
                    Icon(
                      Iconsax.location,
                      size: 12,
                      color: context.secondaryTextColor,
                    ),
                    const SizedBox(width: 4),
                    AppText.smallest(
                      location,
                      color: context.secondaryTextColor,
                    ),
                  ],
                ),
                const SizedBox(height: 2),

                // IP Address
                AppText.smallest(ipAddress, color: context.secondaryTextColor),
                const SizedBox(height: 2),

                // Timestamp
                AppText.smallest(
                  timestamp,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: context.secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
