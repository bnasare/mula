class QuizResult {
  final int totalQuestions;
  final int correctAnswers;
  final int score;
  final int totalPoints;

  const QuizResult({
    required this.totalQuestions,
    required this.correctAnswers,
    required this.score,
    required this.totalPoints,
  });

  bool get passed => correctAnswers >= (totalQuestions / 2).ceil();

  double get percentage => (correctAnswers / totalQuestions) * 100;
}
