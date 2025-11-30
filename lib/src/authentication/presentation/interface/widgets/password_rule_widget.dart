import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mula/shared/presentation/widgets/constants/app_text.dart';
import 'package:mula/shared/utils/extension.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';

class PasswordRuleWidget extends StatelessWidget {
  final bool isActive;
  final String rule;

  const PasswordRuleWidget({
    super.key,
    required this.isActive,
    required this.rule,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: context.responsiveValue(mobile: 12),
          height: context.responsiveValue(mobile: 12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? AppColors.success : AppColors.transparent,
            border: isActive ? null : Border.all(color: AppColors.grey(context)),
          ),
          child: isActive
              ? Icon(
                  CupertinoIcons.check_mark,
                  color: AppColors.white(context),
                  size: context.responsiveValue(mobile: 10),
                )
              : null,
        ),
        SizedBox(width: context.responsiveSpacing(mobile: 8)),
        Expanded(
          child: AppText.smallest(
            rule,
            style: TextStyle(
              color: isActive ? AppColors.black(context) : AppColors.secondaryText(context),
              overflow: TextOverflow.ellipsis,
              fontSize: context.responsiveFontSize(mobile: 12),
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }
}
