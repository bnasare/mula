import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.userName,
    this.userInitial,
    this.profileImageUrl,
    this.onLogout,
  });

  final String userName;
  final String? userInitial;
  final String? profileImageUrl;
  final VoidCallback? onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: AppColors.appPrimary,
            backgroundImage: profileImageUrl != null
                ? NetworkImage(profileImageUrl!)
                : null,
            child: profileImageUrl == null
                ? AppText.large(
                    userInitial ?? userName[0].toUpperCase(),
                    color: AppColors.white(context),
                  )
                : null,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: AppText.medium(
              userName,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
            ),
          ),
          TextButton.icon(
            onPressed: onLogout,
            icon: const Icon(
              Iconsax.logout,
              size: 18,
              color: AppColors.error,
            ),
            label: AppText.smaller(
              context.localize.logOut,
              color: AppColors.error,
            ),
          ),
        ],
      ),
    );
  }
}
