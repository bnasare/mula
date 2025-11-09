import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/utils/extension.dart';

/// A widget that displays a section of accounts grouped by type
/// (e.g., CIS Accounts, CSD Accounts, Mobile Money, Bank Accounts)
class AccountSection extends StatelessWidget {
  /// The title of the section (e.g., "CIS Accounts")
  final String title;

  /// The list of account widgets to display
  final List<Widget> accounts;

  const AccountSection({
    super.key,
    required this.title,
    required this.accounts,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section title
        Text(
          title,
          style: TextStyle(
            fontSize: context.responsiveFontSize(mobile: 16.0),
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryText(context),
          ),
        ),
        SizedBox(height: context.responsiveSpacing(mobile: 16.0)),
        // Account list
        ...accounts.map((account) {
          final isLast = account == accounts.last;
          return Padding(
            padding: EdgeInsets.only(
              bottom: isLast ? 0 : context.responsiveSpacing(mobile: 12.0),
            ),
            child: account,
          );
        }),
      ],
    );
  }
}
