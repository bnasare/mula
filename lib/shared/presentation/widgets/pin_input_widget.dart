import 'package:flutter/material.dart';

import '../../utils/extension.dart';
import '../theme/app_colors.dart';
import 'constants/app_spacer.dart';
import 'constants/app_text.dart';

class PinInputWidget extends StatefulWidget {
  final Function(String) onPinComplete;
  final Widget? leftButton;
  final int pinLength;

  const PinInputWidget({
    super.key,
    required this.onPinComplete,
    this.leftButton,
    this.pinLength = 4,
  });

  @override
  State<PinInputWidget> createState() => _PinInputWidgetState();
}

class _PinInputWidgetState extends State<PinInputWidget> {
  String _pin = '';
  int? _lastEnteredIndex;

  void _onNumberTap(String number) {
    if (_pin.length < widget.pinLength) {
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

      // Check if PIN is complete
      if (_pin.length == widget.pinLength) {
        Future.delayed(const Duration(milliseconds: 500), () {
          widget.onPinComplete(_pin);
        });
      }
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // PIN Dots Display
        _buildPinDisplay(context),
        const AppSpacer.vertical(40),
        // Number Pad
        _buildNumberPad(context),
      ],
    );
  }

  Widget _buildPinDisplay(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.pinLength, (index) {
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

  Widget _buildNumberPad(BuildContext context) {
    return Column(
      children: [
        _buildNumberRow(context, ['1', '2', '3']),
        const AppSpacer.vShort(),
        _buildNumberRow(context, ['4', '5', '6']),
        const AppSpacer.vShort(),
        _buildNumberRow(context, ['7', '8', '9']),
        const AppSpacer.vShort(),
        _buildNumberRow(context, ['left_button', '0', 'backspace']),
      ],
    );
  }

  Widget _buildNumberRow(BuildContext context, List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) {
        if (number == 'left_button') {
          return widget.leftButton ??
              SizedBox(
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
