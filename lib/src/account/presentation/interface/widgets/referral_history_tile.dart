import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

class ReferralHistoryTile extends StatelessWidget {
  const ReferralHistoryTile({
    super.key,
    required this.name,
    required this.dateTime,
    required this.pointsEarned,
    this.avatarColor,
  });

  final String name;
  final String dateTime;
  final int pointsEarned;
  final Color? avatarColor;

  String get _initials {
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = avatarColor ?? AppColors.appPrimary;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: bgColor.withOpacity(0.15),
            child: AppText.smaller(
              _initials,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: bgColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText.smaller(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryText(context),
                  ),
                ),
                const SizedBox(height: 2),
                AppText.smallest(
                  dateTime,
                  color: AppColors.secondaryText(context),
                ),
              ],
            ),
          ),
          AppText.smaller(
            '+ $pointsEarned pts',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: AppColors.appPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
