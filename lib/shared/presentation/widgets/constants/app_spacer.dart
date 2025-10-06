import 'package:flutter/material.dart';

import '../../../../shared/utils/extension.dart';

typedef _Direction = Axis;

class AppSpacer extends StatelessWidget {
  const AppSpacer.vertical(this.space, {super.key})
    : _direction = _Direction.vertical;

  const AppSpacer.horizontal(this.space, {super.key})
    : _direction = _Direction.horizontal;

  // Vertical Spacing
  const AppSpacer.vShorter({super.key})
    : _direction = _Direction.vertical,
      space = 5;

  const AppSpacer.vShort({super.key})
    : _direction = _Direction.vertical,
      space = 10;

  const AppSpacer.vLarge({super.key})
    : _direction = _Direction.vertical,
      space = 20;

  const AppSpacer.vLarger({super.key})
    : _direction = _Direction.vertical,
      space = 30;

  // Horizontal Spacing
  const AppSpacer.hShort({super.key})
    : _direction = _Direction.horizontal,
      space = 10;

  const AppSpacer.hShorter({super.key})
    : _direction = _Direction.horizontal,
      space = 5;

  const AppSpacer.hLarge({super.key})
    : _direction = _Direction.horizontal,
      space = 20;

  const AppSpacer.hLarger({super.key})
    : _direction = _Direction.horizontal,
      space = 30;

  final double space;
  final _Direction _direction;

  @override
  Widget build(BuildContext context) {
    switch (_direction) {
      case Axis.vertical:
        return SizedBox(height: context.responsiveSpacing(mobile: space));
      case Axis.horizontal:
        return SizedBox(width: context.responsiveSpacing(mobile: space));
    }
  }
}
