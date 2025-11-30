import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/snackbar.dart';
import '../../../../../shared/utils/localization_extension.dart';

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: MulaAppBar(
          title: context.localize.reportAnIssue,
          showBottomDivider: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText.smaller(
                context.localize.tellUsWhatsGoingOn,
                color: AppColors.primaryText(context),
              ),
              const SizedBox(height: 24),

              // Issue Description TextField
              TextField(
                controller: _issueController,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: context.localize.describeYourIssue,
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
                text: context.localize.done,
                backgroundColor: AppColors.appPrimary,
                textColor: AppColors.white(context),
                borderRadius: 8,
                padding: EdgeInsets.zero,
                onTap: () {
                  if (_issueController.text.isNotEmpty) {
                    // TODO: Submit issue report
                    Navigator.pop(context);
                    SnackBarHelper.showSuccessSnackBar(
                      context,
                      context.localize.issueReportedSuccessfully,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
