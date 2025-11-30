import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/pin_input_widget.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import 'pin_change_success_screen.dart';

class EnterPinScreen extends StatefulWidget {
  final bool isCurrentPin;

  const EnterPinScreen({
    super.key,
    this.isCurrentPin = true,
  });

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  void _onPinComplete(String pin) {
    // Mock PIN validation - accept any 4-digit PIN
    if (pin.length == 4) {
      // Navigate to appropriate screen after a brief delay
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          if (widget.isCurrentPin) {
            // Navigate to new PIN screen
            NavigationHelper.navigateTo(
              context,
              const EnterPinScreen(isCurrentPin: false),
            );
          } else {
            // Navigate to success screen
            NavigationHelper.navigateTo(
              context,
              const PinChangeSuccessScreen(),
            );
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.isCurrentPin
        ? context.localize.changePin
        : context.localize.createNewPin;

    final heading = widget.isCurrentPin
        ? context.localize.enterYourCurrentPin
        : context.localize.createYourNewPin;

    final subtitle = widget.isCurrentPin
        ? context.localize.verifyIdentity
        : context.localize.choosePinDescription;

    return Scaffold(
      appBar: MulaAppBar(
        title: title,
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.responsivePadding(
            mobile: const EdgeInsets.all(24),
          ),
          child: Column(
            children: [
              const AppSpacer.vLarger(),
              AppText.large(
                heading,
                align: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const AppSpacer.vShort(),
              AppText.smaller(
                subtitle,
                align: TextAlign.center,
                color: AppColors.secondaryText(context),
              ),
              const AppSpacer.vLarger(),
              PinInputWidget(
                pinLength: 4,
                onPinComplete: _onPinComplete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
