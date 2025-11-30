import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';

enum ProfileImageAction { changePhoto, viewFullscreen, deletePhoto }

class ProfileImageBottomSheet extends StatelessWidget {
  const ProfileImageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.hintText(context).withOpacity(0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          // Options
          _BottomSheetOption(
            icon: Iconsax.camera,
            title: 'Change Profile Picture',
            iconColor: AppColors.appPrimary,
            onTap: () => Navigator.pop(context, ProfileImageAction.changePhoto),
          ),
          _BottomSheetOption(
            icon: Iconsax.maximize_4,
            title: 'View Fullscreen',
            iconColor: AppColors.warning,
            onTap: () =>
                Navigator.pop(context, ProfileImageAction.viewFullscreen),
          ),
          _BottomSheetOption(
            icon: Iconsax.trash,
            title: 'Delete Photo',
            iconColor: AppColors.error,
            onTap: () => Navigator.pop(context, ProfileImageAction.deletePhoto),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _BottomSheetOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final VoidCallback onTap;

  const _BottomSheetOption({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: context.primaryTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
