import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/presentation/widgets/snackbar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../authentication/presentation/interface/widgets/tasty_pad_text_field.dart';
import '../widgets/contact_option_tile.dart';
import '../widgets/faq_accordion_tile.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final TextEditingController _issueController = TextEditingController();

  @override
  void dispose() {
    _issueController.dispose();
    super.dispose();
  }

  Future<void> _launchEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@mula.app',
      query: 'subject=${Uri.encodeComponent('Help Request')}',
    );

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        if (context.mounted) {
          SnackBarHelper.showErrorSnackBar(
            context,
            context.localize.couldNotOpenEmailClient,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarHelper.showErrorSnackBar(
          context,
          '${context.localize.errorOpeningEmail}: $e',
        );
      }
    }
  }

  Future<void> _launchPhone(BuildContext context) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+2335506679012');

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        if (context.mounted) {
          SnackBarHelper.showErrorSnackBar(
            context,
            context.localize.couldNotOpenPhoneDialer,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarHelper.showErrorSnackBar(
          context,
          '${context.localize.errorOpeningPhone}: $e',
        );
      }
    }
  }

  void _submitIssue() {
    if (_issueController.text.trim().isEmpty) {
      SnackBarHelper.showWarningSnackBar(
        context,
        context.localize.describeYourIssue,
      );
      return;
    }
    // TODO: Submit issue to backend
    SnackBarHelper.showSuccessSnackBar(
      context,
      context.localize.issueSubmittedSuccessfully,
    );
    _issueController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: MulaAppBar(
          title: context.localize.helpCenter,
          showBottomDivider: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header section
                AppText.medium(
                  context.localize.needHelpTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.primaryTextColor,
                  ),
                ),
                AppSpacer.vShorter(),
                AppText.smaller(
                  context.localize.needHelpSubtitle,
                  style: TextStyle(color: context.secondaryTextColor),
                ),
                AppSpacer.vLarge(),

                // FAQ Section title
                AppText.smaller(
                  context.localize.frequentlyAskedQuestions,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.primaryTextColor,
                  ),
                ),
                AppSpacer.vShort(),

                // FAQ Accordions
                FaqAccordionTile(
                  question: context.localize.faqQuestion1,
                  answer: context.localize.faqAnswer1,
                ),
                FaqAccordionTile(
                  question: context.localize.faqQuestion2,
                  answer: context.localize.faqAnswer2,
                ),
                FaqAccordionTile(
                  question: context.localize.faqQuestion3,
                  answer: context.localize.faqAnswer3,
                ),
                FaqAccordionTile(
                  question: context.localize.faqQuestion4,
                  answer: context.localize.faqAnswer4,
                ),

                AppSpacer.vLarge(),

                // Contact Section
                AppText.smaller(
                  context.localize.callOrSendEmail,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.primaryTextColor,
                  ),
                ),
                AppSpacer.vShort(),

                ContactOptionTile(
                  icon: Iconsax.sms,
                  title: context.localize.sendUsEmailAt,
                  value: 'support@mulaapp.com',
                  iconColor: AppColors.appPrimary,
                  onTap: () => _launchEmail(context),
                ),
                ContactOptionTile(
                  icon: Iconsax.call,
                  title: context.localize.talkToUs,
                  value: '+233 550 667 9012',
                  iconColor: AppColors.info,
                  onTap: () => _launchPhone(context),
                ),

                AppSpacer.vLarge(),

                // Report an issue section
                AppText.smaller(
                  context.localize.reportAnIssue,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: context.primaryTextColor,
                  ),
                ),
                AppSpacer.vShorter(),
                AppText.smallest(
                  context.localize.reportIssueDescription,
                  style: TextStyle(color: context.secondaryTextColor),
                ),
                AppSpacer.vShort(),

                TastyPadTextField(
                  controller: _issueController,
                  hintText: context.localize.describeYourIssue,
                  maxLines: 4,
                  minLines: 4,
                  textCapitalization: TextCapitalization.sentences,
                ),

                AppSpacer.vShort(),
                AppButton(
                  text: context.localize.done,
                  onTap: _submitIssue,
                  borderRadius: 12,
                  backgroundColor: AppColors.appPrimary,
                  textColor: AppColors.white(context),
                  padding: EdgeInsets.zero,
                ),
                AppSpacer.vLarge(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
