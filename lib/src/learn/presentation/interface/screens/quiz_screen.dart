import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../data/dummy_learn_data.dart';
import '../../../domain/entities/quiz.dart';
import '../../../domain/entities/quiz_result.dart';
import '../widgets/quiz_question_card.dart';
import '../widgets/quiz_results_dialog.dart';

class QuizScreen extends StatefulWidget {
  final String lessonId;

  const QuizScreen({super.key, required this.lessonId});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late Quiz? quiz;
  Map<String, String> selectedAnswers = {};
  bool showResults = false;

  @override
  void initState() {
    super.initState();
    quiz = DummyLearnData.getQuiz(widget.lessonId);
  }

  void _onOptionSelected(String questionId, String optionId) {
    if (!showResults) {
      setState(() {
        selectedAnswers[questionId] = optionId;
      });
    }
  }

  void _submitQuiz() {
    if (quiz == null) return;

    // Calculate results
    int correctAnswers = 0;
    int totalScore = 0;

    for (final question in quiz!.questions) {
      final selectedOptionId = selectedAnswers[question.id];
      if (selectedOptionId == question.correctOptionId) {
        correctAnswers++;
        totalScore += question.points;
      }
    }

    final result = QuizResult(
      totalQuestions: quiz!.questions.length,
      correctAnswers: correctAnswers,
      score: totalScore,
      totalPoints: quiz!.totalPoints,
    );

    // Show results
    setState(() {
      showResults = true;
    });

    // Show results dialog
    QuizResultsDialog.show(
      context,
      result: result,
      userName: 'Phil', // TODO: Get actual user name
      onTryAgain: _resetQuiz,
      onExploreResources: () {
        // TODO: Navigate to learning resources
      },
    );
  }

  void _resetQuiz() {
    setState(() {
      selectedAnswers = {};
      showResults = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (quiz == null) {
      return Scaffold(
        backgroundColor: AppColors.offWhite(context),
        appBar: MulaAppBar(
          title: context.localize.takeAQuiz,
          onBackPressed: () => Navigator.of(context).pop(),
        ),
        body: Center(child: AppText.small('Quiz not found')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.offWhite(context),
      appBar: MulaAppBar(
        title: quiz!.title,
        onBackPressed: () => Navigator.of(context).pop(),
        actions: !showResults
            ? [
                GestureDetector(
                  onTap: selectedAnswers.length == quiz!.questions.length
                      ? _submitQuiz
                      : null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Center(
                      child: AppText.smaller(
                        context.localize.done,
                        style: TextStyle(
                          color:
                              selectedAnswers.length == quiz!.questions.length
                              ? AppColors.appPrimary
                              : AppColors.secondaryText(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...quiz!.questions.map((question) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: QuizQuestionCard(
                  question: question,
                  selectedOptionId: selectedAnswers[question.id],
                  showCorrectAnswer: showResults,
                  onOptionSelected: (optionId) =>
                      _onOptionSelected(question.id, optionId),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
