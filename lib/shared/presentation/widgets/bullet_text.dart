import 'package:flutter/material.dart';

import '../../../shared/utils/extension.dart';

class BulletText extends StatelessWidget {
  final double size;
  final Color color;

  const BulletText({super.key, this.size = 14.0, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Text(
      '•',
      style: TextStyle(
        fontSize: context.responsiveFontSize(mobile: size),
        color: color,
      ),
    );
  }
}
