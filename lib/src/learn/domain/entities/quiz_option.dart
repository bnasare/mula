class QuizOption {
  final String id;
  final String label; // a, b, c
  final String text;
  final bool isCorrect;

  const QuizOption({
    required this.id,
    required this.label,
    required this.text,
    required this.isCorrect,
  });
}
