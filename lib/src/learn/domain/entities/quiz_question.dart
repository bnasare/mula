import 'quiz_option.dart';

class QuizQuestion {
  final String id;
  final int questionNumber;
  final String text;
  final List<QuizOption> options;
  final int points;

  const QuizQuestion({
    required this.id,
    required this.questionNumber,
    required this.text,
    required this.options,
    this.points = 5,
  });

  String? get correctOptionId {
    try {
      return options.firstWhere((option) => option.isCorrect).id;
    } catch (e) {
      return null;
    }
  }
}
