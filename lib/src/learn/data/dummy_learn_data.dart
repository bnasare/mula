import 'package:flutter/material.dart';
import '../domain/entities/learning_track.dart';
import '../domain/entities/lesson.dart';

class DummyLearnData {
  static List<LearningTrack> getFeaturedTracks() {
    return [
      const LearningTrack(
        id: '1',
        title: 'New to Investing? Start Here',
        description:
            'If you are new to investing and want to explore the ecosystem, start with this article',
        icon: Icons.eco_outlined,
        durationMinutes: 3,
        gradient: LinearGradient(
          colors: [Color(0xFFFF9F43), Color(0xFFFF8A00)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        category: 'all',
      ),
      const LearningTrack(
        id: '2',
        title: 'Understanding the Market',
        description:
            'If you want to know how the market works and how to make the most of it',
        icon: Icons.attach_money,
        durationMinutes: 5,
        gradient: LinearGradient(
          colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        category: 'all',
      ),
    ];
  }

  static List<Lesson> getLessons({String category = 'all'}) {
    final allLessons = [
      const Lesson(
        id: '1',
        title: 'What is a Mutual Fund?',
        subtitle: 'Pooling money, spreading risk, growing wealth',
        type: 'Article',
        durationMinutes: 3,
        category: 'mutualFunds',
      ),
      const Lesson(
        id: '2',
        title: 'What is a Mutual Fund?',
        subtitle: 'Pooling money, spreading risk, growing wealth',
        type: 'Article',
        durationMinutes: 3,
        category: 'all',
      ),
      const Lesson(
        id: '3',
        title: 'What is a Mutual Fund?',
        subtitle: 'Pooling money, spreading risk, growing wealth',
        type: 'Article',
        durationMinutes: 3,
        category: 'mutualFunds',
      ),
      const Lesson(
        id: '4',
        title: 'What is a Mutual Fund?',
        subtitle: 'Pooling money, spreading risk, growing wealth',
        type: 'Article',
        durationMinutes: 3,
        category: 'all',
      ),
      const Lesson(
        id: '5',
        title: 'Understanding T-Bills',
        subtitle: 'Low risk, guaranteed returns, government backed',
        type: 'Article',
        durationMinutes: 4,
        category: 'tBillsBonds',
      ),
      const Lesson(
        id: '6',
        title: 'Ghana Stock Exchange Basics',
        subtitle: 'Learn about trading stocks on the GSE',
        type: 'Article',
        durationMinutes: 5,
        category: 'ghanaStocks',
      ),
      const Lesson(
        id: '7',
        title: 'Corporate Bonds Explained',
        subtitle: 'Higher returns, moderate risk, fixed income',
        type: 'Article',
        durationMinutes: 6,
        category: 'tBillsBonds',
      ),
      const Lesson(
        id: '8',
        title: 'Diversification Strategies',
        subtitle: 'Spread your investments across different asset classes',
        type: 'Article',
        durationMinutes: 4,
        category: 'all',
      ),
    ];

    if (category == 'all') {
      return allLessons;
    }

    return allLessons.where((lesson) => lesson.category == category).toList();
  }

  static List<String> getCategories() {
    return ['all', 'ghanaStocks', 'tBillsBonds', 'mutualFunds'];
  }
}
