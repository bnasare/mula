import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';

class FaqAccordionTile extends StatefulWidget {
  const FaqAccordionTile({
    super.key,
    required this.question,
    required this.answer,
    this.initiallyExpanded = false,
  });

  final String question;
  final String answer;
  final bool initiallyExpanded;

  @override
  State<FaqAccordionTile> createState() => _FaqAccordionTileState();
}

class _FaqAccordionTileState extends State<FaqAccordionTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          expansionTileTheme: ExpansionTileThemeData(
            backgroundColor: context.cardColor,
            collapsedBackgroundColor: context.cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: context.cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: ExpansionTile(
            initiallyExpanded: widget.initiallyExpanded,
            tilePadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            childrenPadding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            title: AppText.smaller(
              widget.question,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: context.primaryTextColor,
              ),
            ),
            trailing: Icon(
              IconlyLight.arrow_down_2,
              size: 20,
              color: context.secondaryTextColor,
            ),
            children: [
              AppText.smaller(
                widget.answer,
                style: TextStyle(
                  color: context.secondaryTextColor,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
