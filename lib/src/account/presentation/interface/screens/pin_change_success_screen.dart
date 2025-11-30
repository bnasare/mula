import 'package:flutter/material.dart';

import '../../../../../shared/presentation/widgets/confetti_success_screen.dart';
import '../../../../../shared/utils/localization_extension.dart';

class PinChangeSuccessScreen extends StatelessWidget {
  const PinChangeSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ConfettiSuccessScreen(
      title: context.localize.pinChangedSuccessfully,
      description: context.localize.pinChangeSuccessDescription,
      primaryButtonText: context.localize.done,
      onPrimaryButtonTap: () {
        // Pop all screens back to Security Settings or Account Tab
        Navigator.of(context).popUntil(
          (route) =>
              route.isFirst || route.settings.name == '/security-settings',
        );
      },
    );
  }
}
