import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppText.small(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: context.secondaryTextColor,
              ),
            ),
          ),
          ...children.map((child) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: child,
              )),
        ],
      ),
    );
  }
}
