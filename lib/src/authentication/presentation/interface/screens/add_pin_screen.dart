import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/confetti_success_screen.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';

class AddPinScreen extends StatefulWidget {
  const AddPinScreen({super.key});

  @override
  State<AddPinScreen> createState() => _AddPinScreenState();
}

class _AddPinScreenState extends State<AddPinScreen> {
  String _pin = '';
  final int _pinLength = 4;
  int? _lastEnteredIndex;

  void _onNumberTap(String number) {
    if (_pin.length < _pinLength) {
      setState(() {
        _pin += number;
        _lastEnteredIndex = _pin.length - 1;
      });

      // Hide the number after a brief delay
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            if (_lastEnteredIndex == _pin.length - 1) {
              _lastEnteredIndex = null;
            }
          });
        }
      });
    }
  }

  void _onBackspace() {
    if (_pin.isNotEmpty) {
      setState(() {
        _pin = _pin.substring(0, _pin.length - 1);
        _lastEnteredIndex = null;
      });
    }
  }

  void _onCreatePin() {
    if (_pin.length == _pinLength) {
      // Navigate to PIN success screen
      NavigationHelper.navigateTo(
        context,
        ConfettiSuccessScreen(
          title: context.localize.pinCreatedSuccessfully,
          description: context.localize.pinCreatedDescription,
          primaryButtonText: context.localize.continueButton,
          onPrimaryButtonTap: () {
            // TODO: Navigate to home or next screen
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white(context),
      appBar: MulaAppBarHelpers.withProgress(
        backgroundColor: AppColors.white(context),
        title: context.localize.security,
        currentStep: 4,
        totalSteps: 5,
        progressColor: AppColors.appPrimary.withValues(alpha: 0.7),
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SafeArea(
        child: Padding(
          padding: context.responsivePadding(
            mobile: const EdgeInsets.all(24.0),
          ),
          child: Column(
            children: [
              // Title
              AppText.medium(
                context.localize.addAPin,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const AppSpacer.vShorter(),
              // Description
              AppText.smaller(
                context.localize.addPinDescription,
                color: AppColors.secondaryText(context),
              ),
              const Spacer(),
              // PIN Dots Display
              _buildPinDisplay(),
              // Number Pad
              const Spacer(),
              _buildNumberPad(),
              const Spacer(),
              // Create PIN Button
              AppButton(
                text: context.localize.createPin,
                backgroundColor: _pin.length == _pinLength
                    ? AppColors.appPrimary
                    : AppColors.lightGrey(context),
                textColor: _pin.length == _pinLength
                    ? Colors.white
                    : AppColors.secondaryText(context),
                borderRadius: 12,
                padding: EdgeInsets.zero,
                onTap: _onCreatePin,
              ),
              const AppSpacer.vLarge(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinDisplay() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pinLength, (index) {
        final isFilled = index < _pin.length;
        final showNumber = isFilled && _lastEnteredIndex == index;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: SizedBox(
            width: 24,
            height: 24,
            child: Center(
              child: showNumber
                  ? Text(
                      _pin[index],
                      style: TextStyle(
                        fontSize: context.responsiveFontSize(mobile: 22),
                        fontWeight: FontWeight.w400,
                        color: AppColors.black(context),
                      ),
                    )
                  : Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: isFilled
                            ? AppColors.black(context)
                            : AppColors.lightGrey(context),
                        shape: BoxShape.circle,
                      ),
                    ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        _buildNumberRow(['1', '2', '3']),
        const AppSpacer.vShort(),
        _buildNumberRow(['4', '5', '6']),
        const AppSpacer.vShort(),
        _buildNumberRow(['7', '8', '9']),
        const AppSpacer.vShort(),
        _buildNumberRow(['', '0', 'backspace']),
      ],
    );
  }

  Widget _buildNumberRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) {
        if (number.isEmpty) {
          return SizedBox(
            width: context.responsiveValue(mobile: 70),
            height: context.responsiveValue(mobile: 70),
          );
        }

        if (number == 'backspace') {
          return GestureDetector(
            onTap: _onBackspace,
            child: Container(
              width: context.responsiveValue(mobile: 70),
              height: context.responsiveValue(mobile: 70),
              decoration: BoxDecoration(
                color: AppColors.lightGrey(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.backspace_outlined,
                color: AppColors.black(context),
                size: context.responsiveValue(mobile: 24),
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: () => _onNumberTap(number),
          child: Container(
            width: context.responsiveValue(mobile: 70),
            height: context.responsiveValue(mobile: 70),
            decoration: BoxDecoration(
              color: AppColors.lightGrey(context),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: AppText.large(
                number,
                style: TextStyle(
                  fontWeight: FontWeight.w200,
                  color: AppColors.black(context),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
