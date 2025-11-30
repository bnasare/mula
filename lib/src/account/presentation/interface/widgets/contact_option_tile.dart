import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

class ContactOptionTile extends StatelessWidget {
  const ContactOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
    required this.iconColor,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
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
                    const SizedBox(height: 2),
                    AppText.smallest(
                      value,
                      style: TextStyle(
                        color: context.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                IconlyLight.arrow_right_2,
                size: 20,
                color: context.secondaryTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
