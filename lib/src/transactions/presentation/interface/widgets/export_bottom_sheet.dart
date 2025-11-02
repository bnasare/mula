import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

/// Bottom sheet for choosing export format
class ExportBottomSheet extends StatefulWidget {
  const ExportBottomSheet({super.key});

  @override
  State<ExportBottomSheet> createState() => _ExportBottomSheetState();
}

class _ExportBottomSheetState extends State<ExportBottomSheet> {
  String? _selectedFormat;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText.large(
                'Choose file format',
                color: AppColors.primaryText(context),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // PDF Format Option
          _buildFormatOption('PDF Format'),
          const SizedBox(height: 12),

          // CSV Option
          _buildFormatOption('CSV'),
          const SizedBox(height: 32),

          // Apply Button
          AppButton(
            text: 'Apply',
            backgroundColor: _selectedFormat != null
                ? AppColors.appPrimary
                : AppColors.appPrimary.withOpacity(0.5),
            textColor: Colors.white,
            borderRadius: 8,
            padding: EdgeInsets.zero,
            onTap: _selectedFormat != null
                ? () {
                    // TODO: Export with selected format
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Exporting as $_selectedFormat'),
                      ),
                    );
                  }
                : null,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildFormatOption(String format) {
    final isSelected = _selectedFormat == format;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedFormat = format);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.offWhite(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.appPrimary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppText.small(
                format,
                color: AppColors.primaryText(context),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppColors.appPrimary,
                size: 24,
              )
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.border(context),
                    width: 2,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
