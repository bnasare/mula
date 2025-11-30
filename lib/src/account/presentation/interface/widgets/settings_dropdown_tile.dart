import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

class SettingsDropdownTile<T> extends StatelessWidget {
  const SettingsDropdownTile({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.value,
    required this.items,
    required this.onChanged,
    this.displayBuilder,
  });

  final IconData icon;
  final String title;
  final Color iconColor;
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final String Function(T)? displayBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
            child: AppText.smaller(
              title,
              color: context.primaryTextColor,
              maxLines: 1,
              clipped: true,
            ),
          ),
          DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: context.secondaryTextColor,
              ),
              isDense: true,
              dropdownColor: context.cardColor,
              borderRadius: BorderRadius.circular(12),
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 14,
                color: context.secondaryTextColor,
              ),
              items: items.map((item) {
                final displayText =
                    displayBuilder?.call(item) ?? item.toString();
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(displayText),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
