import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';

/// Learning corner card with educational content
class LearningCornerCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onLearnMore;

  const LearningCornerCard({
    super.key,
    required this.title,
    required this.description,
    this.onLearnMore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF9F43), Color(0xFFFF8A00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF9F43).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          AppText.medium(
            title,
            color: Colors.white,
          ),
          const SizedBox(height: 8),

          // Description
          AppText.small(
            description,
            color: Colors.white.withOpacity(0.95),
          ),
          const SizedBox(height: 16),

          // Learn more button and share/save icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Learn more button
              GestureDetector(
                onTap: onLearnMore,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: AppText.smallest(
                    context.localize.learnMore,
                    color: const Color(0xFFFF9F43),
                  ),
                ),
              ),

              // Action icons
              Row(
                children: [
                  _IconButton(
                    icon: IconlyLight.send,
                    onTap: () {
                      // TODO: Implement share
                    },
                  ),
                  const SizedBox(width: 8),
                  _IconButton(
                    icon: IconlyLight.bookmark,
                    onTap: () {
                      // TODO: Implement save
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Icon button for learning corner actions
class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          size: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
