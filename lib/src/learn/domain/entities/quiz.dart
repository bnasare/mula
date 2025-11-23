import 'quiz_question.dart';

class Quiz {
  final String id;
  final String title;
  final String lessonId;
  final List<QuizQuestion> questions;

  const Quiz({
    required this.id,
    required this.title,
    required this.lessonId,
    required this.questions,
  });

  int get totalPoints {
    return questions.fold(0, (sum, question) => sum + question.points);
  }
}
