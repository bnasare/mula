import 'package:mula/shared/presentation/widgets/constants/app_text.dart';
import 'package:mula/shared/utils/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            color: isActive ? Colors.green : Colors.transparent,
            border: isActive ? null : Border.all(color: Colors.grey),
          ),
          child:
              isActive
                  ? Icon(
                    CupertinoIcons.check_mark,
                    color: Colors.white,
                    size: context.responsiveValue(mobile: 10),
                  )
                  : null,
        ),
        SizedBox(width: context.responsiveSpacing(mobile: 8)),
        Expanded(
          child: AppText.smallest(
            rule,
            style: TextStyle(
              color: isActive ? Colors.black87 : Colors.black54,
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
