import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mula/shared/presentation/widgets/app_button.dart';
import 'package:mula/shared/presentation/widgets/constants/app_spacer.dart';
import 'package:mula/shared/utils/extension.dart';

import '../../../../../shared/data/image_assets.dart';
import '../../../../../shared/data/svg_assets.dart';
import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/rounded_linear_progress_indicator.dart';
import '../../../domain/entities/onboarding.dart';
import '../../bloc/onboarding_mixin.dart';

class OnboardingScreen extends StatefulWidget with OnboardingMixin {
  OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Onboarding> _pages = [
    Onboarding(
      image: ImageAssets.onboarding2,
      title: "🍽️ Join the Ultimate\nFood Community!",
      subtitle: "Join Thousands of Chefs And Creators!",
      peopleIcon: ImageAssets.multipeople,
    ),
    Onboarding(
      image: ImageAssets.onboarding,
      title: "🔥 Discover Tastes\nThat Match Your Style",
      subtitle: "Find inspiration for your next meal",
      peopleIcon: ImageAssets.multipeople,
    ),
    Onboarding(
      image: ImageAssets.onboarding3,
      title: "🎨 Create & Express\nYour Culinary Voice",
      subtitle: "Connect with food lovers everywhere",
      peopleIcon: ImageAssets.multipeople,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      widget.completeOnboardingChecks();
      // NavigationHelper.navigateToReplacement(context, const SignUpScreen());
    }
  }

  void _skipOnboarding() {
    widget.completeOnboardingChecks();
    // NavigationHelper.navigateToReplacement(context, const SignUpScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // PageView for background images
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Image(
                    image: AssetImage(_pages[index].image),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(221, 17, 17, 17),
                          AppColors.transparent,
                        ],
                        stops: [0.1, 1],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          // Top bar with logo, skip button, and progress indicator
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: context.responsiveSpacing(mobile: 16),
            right: context.responsiveSpacing(mobile: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      SvgAssets.logo,
                      width: context.responsiveValue(mobile: 45),
                      height: context.responsiveValue(mobile: 45),
                    ),
                    TextButton(
                      onPressed: _skipOnboarding,
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        padding: context.responsivePadding(
                          mobile: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: context.responsiveFontSize(mobile: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                const AppSpacer.vShort(),
                RoundedLinearProgressIndicator(
                  value: (_currentPage + 1) / _pages.length,
                  backgroundColor: const Color(0xFFF2F2F2),
                  color: AppColors.orange,
                  minHeight: 6,
                  borderRadius: 3,
                ),
              ],
            ),
          ),

          // Bottom content with title, subtitle, and button
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.responsiveSpacing(mobile: 16),
              MediaQuery.of(context).padding.top + 16,
              context.responsiveSpacing(mobile: 16),
              MediaQuery.of(context).padding.bottom + 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  _pages[_currentPage].title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: AppColors.white(context),
                    fontWeight: FontWeight.bold,
                    fontSize: context.responsiveFontSize(mobile: 28),
                  ),
                ),
                const SizedBox(height: 12),
                FittedBox(
                  child: Row(
                    children: [
                      Image.asset(_pages[_currentPage].peopleIcon),
                      const SizedBox(width: 4),
                      Text(
                        _pages[_currentPage].subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white(context),
                          fontSize: context.responsiveFontSize(mobile: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                AppButton(
                  padding: const EdgeInsets.all(0),
                  text:
                      _currentPage == _pages.length - 1
                          ? "Get Started"
                          : "Next",
                  borderRadius: 15,
                  height: context.responsiveValue(mobile: 55),
                  textColor: AppColors.white(context),
                  backgroundColor: Theme.of(context).primaryColor,
                  onTap: _nextPage,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
