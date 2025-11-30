import 'dart:io';

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
    this.profileImageFile,
    this.onLogout,
    this.onProfileImageTap,
  });

  final String userName;
  final String? userInitial;
  final String? profileImageUrl;
  final File? profileImageFile;
  final VoidCallback? onLogout;
  final VoidCallback? onProfileImageTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: AppColors.appPrimary,
                backgroundImage: profileImageFile != null
                    ? FileImage(profileImageFile!)
                    : (profileImageUrl != null
                          ? NetworkImage(profileImageUrl!)
                          : null),
                child: profileImageFile == null && profileImageUrl == null
                    ? AppText.large(
                        userInitial ?? userName[0].toUpperCase(),
                        color: AppColors.white(context),
                      )
                    : null,
              ),
              if (onProfileImageTap != null)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: onProfileImageTap,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: AppColors.appPrimary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.card(context),
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        Iconsax.more,
                        size: 12,
                        color: AppColors.white(context),
                      ),
                    ),
                  ),
                ),
            ],
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
            icon: const Icon(Iconsax.logout, size: 18, color: AppColors.error),
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
