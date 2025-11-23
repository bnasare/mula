class Lesson {
  final String id;
  final String title;
  final String subtitle;
  final String type;
  final int durationMinutes;
  final String? imageUrl;
  final String category;

  const Lesson({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.type,
    required this.durationMinutes,
    this.imageUrl,
    required this.category,
  });
}
