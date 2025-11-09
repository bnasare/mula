import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../../utils/extension.dart';

class OTPInputWidget extends StatefulWidget {
  final int length;
  final Function(String) onCompleted;
  final Function(String)? onChanged;

  const OTPInputWidget({
    super.key,
    this.length = 6,
    required this.onCompleted,
    this.onChanged,
  });

  @override
  State<OTPInputWidget> createState() => _OTPInputWidgetState();
}

class _OTPInputWidgetState extends State<OTPInputWidget> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onTextChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }

    // Get current OTP value
    String currentOtp = _controllers
        .map((controller) => controller.text)
        .join();

    // Call onChanged callback
    widget.onChanged?.call(currentOtp);

    // Call onCompleted if all fields are filled
    if (currentOtp.length == widget.length) {
      widget.onCompleted(currentOtp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (index) {
        return ValueListenableBuilder<TextEditingValue>(
          valueListenable: _controllers[index],
          builder: (context, value, child) {
            final hasValue = value.text.isNotEmpty;
            return Container(
              width: context.responsiveValue(mobile: 55),
              height: context.responsiveValue(mobile: 55),
              decoration: BoxDecoration(
                color: hasValue
                    ? AppColors.appPrimary.withValues(alpha: 0.1)
                    : Colors.transparent,
                border: Border.all(
                  color: hasValue
                      ? AppColors.appPrimary
                      : AppColors.grey(context).withValues(alpha: 0.5),
                  width: hasValue ? 1.5 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                style: TextStyle(
                  fontSize: context.responsiveFontSize(mobile: 18),
                  fontWeight: FontWeight.w600,
                  color: AppColors.black(context),
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) => _onTextChanged(value, index),
              ),
            );
          },
        );
      }),
    );
  }
}
