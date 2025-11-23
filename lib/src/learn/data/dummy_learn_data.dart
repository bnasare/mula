import 'package:flutter/material.dart';
import '../../../shared/presentation/theme/app_colors.dart';
import '../domain/entities/learning_track.dart';
import '../domain/entities/lesson.dart';
import '../domain/entities/lesson_detail.dart';
import '../domain/entities/comment.dart';
import '../domain/entities/quiz.dart';
import '../domain/entities/quiz_question.dart';
import '../domain/entities/quiz_option.dart';
import '../domain/entities/search_item.dart';

class DummyLearnData {
  static List<LearningTrack> getFeaturedTracks() {
    return [
      LearningTrack(
        id: '1',
        title: 'New to Investing? Start Here',
        description:
            'If you are new to investing and want to explore the ecosystem, start with this article',
        icon: '🌱',
        durationMinutes: 3,
        gradient: LinearGradient(
          colors: AppColors.orangeGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        category: 'all',
      ),
      LearningTrack(
        id: '2',
        title: 'Understanding the Market',
        description:
            'If you want to know how the market works and how to make the most of it',
        icon: '💰',
        durationMinutes: 5,
        gradient: LinearGradient(
          colors: AppColors.purpleGradient,
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

  static LessonDetail? getLessonDetail(String lessonId) {
    // For now, we'll provide detailed content for the "What are Bonds?" article
    if (lessonId == '1' || lessonId == '2' || lessonId == '3' || lessonId == '4') {
      return LessonDetail(
        id: lessonId,
        title: 'What are Bonds?',
        date: '25th July 2025',
        durationMinutes: 3,
        views: '20',
        hasVideo: true,
        content: _getBondsArticleContent(),
        category: 'tBillsBonds',
        comments: _getComments(),
        isRead: false,
      );
    }
    return null;
  }

  static String _getBondsArticleContent() {
    return '''
**What are Bonds?** 📚

Think of a bond like a personal loan, but for a government or a large company. When you buy a bond, you're lending your money to the issuer for a specific period of time. In return, the issuer promises to pay you back your original amount (the principal) on a specific date in the future (the maturity date), plus regular interest payments (called coupon payments) along the way.

It's a way for governments and companies to raise money for big projects. And for you, it's a chance to invest their businesses without going to a bank.

**The Key Players in the Bond World**

There are three main players in every bond:

1. **The Borrower**: This is the entity that issues the bond. It can be a government (like the Ministry of Finance in a government) or a company (like a big bank or corporation).

2. **The Investor**: This is you! You are the one lending the money.

3. **The Agreement**: This is the bond itself. It outlines all the terms of the loan: how much interest will be paid, when it'll be paid, and when the original money will be returned.

**How Bonds Make You Money**

You earn money from a bond in two main ways:

• **Coupon Payments**: These are the regular interest payments you receive from the borrower. They are usually paid once or twice a year.

• **Principal Repayment**: When the bond reaches its maturity date, the issuer pays you back your initial investment.

Bonds are generally considered a **low-risk investment** compared to stocks. This is because the interest payments and the principal repayment are guaranteed by the issuer (as long as they don't go bankrupt).

**Bonds vs. Stocks: A Simple Analogy**

Imagine you have a friend who wants to start a business.

• If you buy a **stock** in their business, you become a part-owner. You share in the profits if the business does well, but you also share in the losses if it does poorly. Your potential for reward is high, but so is your risk.

• If you buy a **bond** from your friend's business, you are a lender, not an owner. They promise to pay you back your money plus interest, regardless of how the business performs. Your potential for reward is fixed, but your risk is much lower.
''';
  }

  static List<Comment> _getComments() {
    return [
      const Comment(
        id: '1',
        authorName: 'Nicholas Asante',
        authorAvatar: '',
        text:
            'This article was so helpful! The analogy about lending money to a friend\'s business made it super easy to understand. The quiz at the end was a great way to test my knowledge.',
        timestamp: '2d',
      ),
      Comment(
        id: '2',
        authorName: 'Michel Kyei',
        authorAvatar: '',
        text:
            'This article was so helpful! The analogy about lending money to a friend\'s business made it super easy to understand. The quiz at the end was a great way to test my knowledge.',
        timestamp: '1d',
        replies: [
          const Comment(
            id: '2-1',
            authorName: 'Sarah Johnson',
            authorAvatar: '',
            text: 'Glad you found it helpful! The team works hard on these.',
            timestamp: '1d',
          ),
        ],
      ),
    ];
  }

  static Quiz? getQuiz(String lessonId) {
    // For now, provide a quiz for bonds lessons
    if (lessonId == '1' || lessonId == '2' || lessonId == '3' || lessonId == '4') {
      return Quiz(
        id: 'quiz_bonds_1',
        title: 'Take a quiz',
        lessonId: lessonId,
        questions: [
          QuizQuestion(
            id: 'q1',
            questionNumber: 1,
            text: 'When you buy a bond, you are...',
            points: 5,
            options: const [
              QuizOption(
                id: 'q1_a',
                label: 'a)',
                text: 'Becoming a part-owner of a company.',
                isCorrect: false,
              ),
              QuizOption(
                id: 'q1_b',
                label: 'b)',
                text: 'Lending money to a government or company.',
                isCorrect: true,
              ),
              QuizOption(
                id: 'q1_c',
                label: 'c)',
                text: 'Gifting money to a business',
                isCorrect: false,
              ),
            ],
          ),
          QuizQuestion(
            id: 'q2',
            questionNumber: 2,
            text: 'What is the name of the regular interest payment you receive from a bond?',
            points: 5,
            options: const [
              QuizOption(
                id: 'q2_a',
                label: 'a)',
                text: 'Dividend',
                isCorrect: false,
              ),
              QuizOption(
                id: 'q2_b',
                label: 'b)',
                text: 'Coupon',
                isCorrect: true,
              ),
              QuizOption(
                id: 'q2_c',
                label: 'c)',
                text: 'Principal',
                isCorrect: false,
              ),
            ],
          ),
          QuizQuestion(
            id: 'q3',
            questionNumber: 3,
            text: 'What is the name of the regular interest payment you receive from a bond?',
            points: 5,
            options: const [
              QuizOption(
                id: 'q3_a',
                label: 'a)',
                text: 'Dividend',
                isCorrect: false,
              ),
              QuizOption(
                id: 'q3_b',
                label: 'b)',
                text: 'Coupon',
                isCorrect: true,
              ),
              QuizOption(
                id: 'q3_c',
                label: 'c)',
                text: 'Principal',
                isCorrect: false,
              ),
            ],
          ),
          QuizQuestion(
            id: 'q4',
            questionNumber: 4,
            text: 'What is the name of the regular interest payment you receive from a bond?',
            points: 5,
            options: const [
              QuizOption(
                id: 'q4_a',
                label: 'a)',
                text: 'Dividend',
                isCorrect: false,
              ),
              QuizOption(
                id: 'q4_b',
                label: 'b)',
                text: 'Coupon',
                isCorrect: true,
              ),
              QuizOption(
                id: 'q4_c',
                label: 'c)',
                text: 'Principal',
                isCorrect: false,
              ),
            ],
          ),
        ],
      );
    }
    return null;
  }

  static List<SearchItem> getSearchHistory() {
    return const [
      SearchItem(
        id: 'h1',
        title: 'MTNGH',
        type: SearchItemType.history,
      ),
      SearchItem(
        id: 'h2',
        title: 'CCMF',
        type: SearchItemType.history,
      ),
      SearchItem(
        id: 'h3',
        title: 'CB 18-APR-28',
        type: SearchItemType.history,
      ),
    ];
  }

  static List<SearchItem> getPopularSearches() {
    return const [
      SearchItem(
        id: 'p1',
        title: 'Stocks',
        type: SearchItemType.popular,
      ),
      SearchItem(
        id: 'p2',
        title: 'High-Yield Funds',
        type: SearchItemType.popular,
      ),
      SearchItem(
        id: 'p3',
        title: 'T-Bills',
        type: SearchItemType.popular,
      ),
    ];
  }

  static List<String> getStockLevels() {
    return [
      'All Stocks',
      'Blue Chip',
      'Mid Cap',
      'Small Cap',
    ];
  }

  static List<String> getSearchCategories() {
    return [
      'All Categories',
      'Stocks',
      'Bonds',
      'T-Bills',
      'Mutual Funds',
      'High-Yield Funds',
    ];
  }
}
