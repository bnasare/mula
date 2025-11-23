class Comment {
  final String id;
  final String authorName;
  final String authorAvatar;
  final String text;
  final String timestamp;
  final List<Comment> replies;

  const Comment({
    required this.id,
    required this.authorName,
    required this.authorAvatar,
    required this.text,
    required this.timestamp,
    this.replies = const [],
  });
}
