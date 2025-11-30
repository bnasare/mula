import 'package:flutter/cupertino.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

class NotificationToggleTile extends StatelessWidget {
  const NotificationToggleTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    required this.icon,
    required this.iconColor,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: context.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 20, color: iconColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.smaller(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: context.primaryTextColor,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    AppText.smallest(
                      subtitle!,
                      style: TextStyle(color: context.secondaryTextColor),
                    ),
                  ],
                ],
              ),
            ),
            CupertinoSwitch(
              value: value,
              onChanged: onChanged,
              activeTrackColor: AppColors.appPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
