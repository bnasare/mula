import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';

/// Screen for reporting issues
class ReportIssueScreen extends StatefulWidget {
  const ReportIssueScreen({super.key});

  @override
  State<ReportIssueScreen> createState() => _ReportIssueScreenState();
}

class _ReportIssueScreenState extends State<ReportIssueScreen> {
  final TextEditingController _issueController = TextEditingController();

  @override
  void dispose() {
    _issueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MulaAppBarHelpers.simple(
        title: 'Report an issue',
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.small(
              "Tell us what's going on and we'll get back to you shortly",
              color: AppColors.secondaryText(context),
            ),
            const SizedBox(height: 24),

            // Issue Description TextField
            TextField(
              controller: _issueController,
              maxLines: 10,
              decoration: InputDecoration(
                hintText: 'Describe your issue...',
                hintStyle: TextStyle(
                  color: AppColors.secondaryText(context),
                  fontSize: 14,
                ),
                filled: true,
                fillColor: AppColors.offWhite(context),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),

            // Done Button
            AppButton(
              text: 'Done',
              backgroundColor: AppColors.appPrimary,
              textColor: Colors.white,
              borderRadius: 8,
              padding: EdgeInsets.zero,
              onTap: () {
                if (_issueController.text.isNotEmpty) {
                  // TODO: Submit issue report
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Issue reported successfully'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
