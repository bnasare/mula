import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../../utils/extension.dart';

class BulletText extends StatelessWidget {
  final double size;
  final Color? color;

  const BulletText({super.key, this.size = 14.0, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      '•',
      style: TextStyle(
        fontSize: context.responsiveFontSize(mobile: size),
        color: color ?? AppColors.black(context),
      ),
    );
  }
}
