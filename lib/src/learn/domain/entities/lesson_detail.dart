import 'comment.dart';

class LessonDetail {
  final String id;
  final String title;
  final String date;
  final int durationMinutes;
  final String views;
  final String? heroImageUrl;
  final bool hasVideo;
  final String content;
  final String category;
  final List<Comment> comments;
  final bool isRead;

  const LessonDetail({
    required this.id,
    required this.title,
    required this.date,
    required this.durationMinutes,
    required this.views,
    this.heroImageUrl,
    this.hasVideo = false,
    required this.content,
    required this.category,
    this.comments = const [],
    this.isRead = false,
  });

  LessonDetail copyWith({
    String? id,
    String? title,
    String? date,
    int? durationMinutes,
    String? views,
    String? heroImageUrl,
    bool? hasVideo,
    String? content,
    String? category,
    List<Comment>? comments,
    bool? isRead,
  }) {
    return LessonDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      views: views ?? this.views,
      heroImageUrl: heroImageUrl ?? this.heroImageUrl,
      hasVideo: hasVideo ?? this.hasVideo,
      content: content ?? this.content,
      category: category ?? this.category,
      comments: comments ?? this.comments,
      isRead: isRead ?? this.isRead,
    );
  }
}
