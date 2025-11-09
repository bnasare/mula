import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mula/shared/data/svg_assets.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/pin_input_widget.dart';
import '../../../../../shared/utils/extension.dart';
import '../../../../../shared/utils/localization_extension.dart';

class EnterPinScreen extends StatefulWidget {
  const EnterPinScreen({super.key});

  @override
  State<EnterPinScreen> createState() => _EnterPinScreenState();
}

class _EnterPinScreenState extends State<EnterPinScreen> {
  String _pin = '';

  void _onPinComplete(String pin) {
    setState(() {
      _pin = pin;
    });
  }

  void _onContinue() {
    if (_pin.length == 4) {
      // TODO: Verify PIN with backend
      Navigator.pop(context);
    }
  }

  void _onFaceIdTap() {
    // TODO: Implement Face ID authentication
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBarHelpers.simple(
        title: '',
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
                context.localize.accessYourMulaAccount,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              const AppSpacer.vShorter(),
              // Description
              AppText.smaller(
                context.localize.enterYourPin,
                color: AppColors.secondaryText(context),
              ),
              const Spacer(),
              // PIN Input Widget with Face ID button
              PinInputWidget(
                onPinComplete: _onPinComplete,
                leftButton: GestureDetector(
                  onTap: _onFaceIdTap,
                  child: Container(
                    width: context.responsiveValue(mobile: 70),
                    height: context.responsiveValue(mobile: 70),
                    decoration: BoxDecoration(
                      color: AppColors.lightGrey(context),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        SvgAssets.faceid,
                        width: context.responsiveValue(mobile: 32),
                        height: context.responsiveValue(mobile: 32),
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              // Continue Button
              AppButton(
                text: context.localize.continueButton,
                backgroundColor: _pin.length == 4
                    ? AppColors.appPrimary
                    : AppColors.lightGrey(context),
                textColor: _pin.length == 4
                    ? Colors.white
                    : AppColors.secondaryText(context),
                borderRadius: 12,
                padding: EdgeInsets.zero,
                onTap: _onContinue,
              ),
              const AppSpacer.vLarge(),
            ],
          ),
        ),
      ),
    );
  }
}
