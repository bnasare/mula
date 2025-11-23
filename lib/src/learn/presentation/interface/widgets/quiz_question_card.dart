import 'package:flutter/material.dart';

import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../domain/entities/quiz_question.dart';
import 'quiz_option_button.dart';

class QuizQuestionCard extends StatelessWidget {
  final QuizQuestion question;
  final String? selectedOptionId;
  final bool showCorrectAnswer;
  final Function(String) onOptionSelected;

  const QuizQuestionCard({
    super.key,
    required this.question,
    this.selectedOptionId,
    this.showCorrectAnswer = false,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question header
        AppText.smaller(
          '${context.localize.question(question.questionNumber)}: ${question.text}',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),

        // Options
        ...question.options.map((option) {
          return QuizOptionButton(
            option: option,
            isSelected: selectedOptionId == option.id,
            showCorrectAnswer: showCorrectAnswer,
            onTap: () => onOptionSelected(option.id),
          );
        }),
      ],
    );
  }
}
