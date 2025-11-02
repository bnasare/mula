import 'package:flutter/material.dart';

import '../../../../../shared/data/image_assets.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/app_button.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import 'mula_bot_chat_screen.dart';

/// Welcome screen for Mula Bot
class MulaBotWelcomeScreen extends StatelessWidget {
  const MulaBotWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite(context),
      appBar: MulaAppBarHelpers.simple(title: 'Mula'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // AI Bot Icon
              Image.asset(
                ImageAssets.ai,
                width: 120,
                height: 120,
              ),
              const SizedBox(height: 40),

              // Title
              AppText.large(
                context.localize.hiImMulaBot,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText(context),
                ),
              ),
              const SizedBox(height: 16),

              // Subtitle
              AppText.medium(
                context.localize.yourPersonalGuide,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.secondaryText(context),
                ),
                align: TextAlign.center,
              ),
              const SizedBox(height: 60),

              // Start Chat Button
              AppButton(
                text: context.localize.startChat,
                backgroundColor: AppColors.appPrimary,
                textColor: Colors.white,
                borderRadius: 12,
                height: 50,
                padding: EdgeInsets.zero,
                onTap: () {
                  NavigationHelper.navigateTo(
                    context,
                    const MulaBotChatScreen(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
