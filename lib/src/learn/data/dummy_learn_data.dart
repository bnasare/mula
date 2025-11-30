import 'package:flutter/material.dart';
import '../../../shared/presentation/theme/app_colors.dart';
import '../domain/entities/learning_track.dart';
import '../domain/entities/lesson.dart';
import '../domain/entities/lesson_detail.dart';
import '../domain/entities/comment.dart';
import '../domain/entities/quiz.dart';
import '../domain/entities/quiz_question.dart';
import '../domain/entities/quiz_option.dart';
import '../../../shared/domain/entities/search_item.dart';

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
        title: 'Understanding Stocks',
        subtitle: 'Own a piece of your favorite companies',
        type: 'Article',
        durationMinutes: 4,
        category: 'ghanaStocks',
      ),
      const Lesson(
        id: '3',
        title: 'T-Bills Explained',
        subtitle: 'Low risk, guaranteed returns, government backed',
        type: 'Article',
        durationMinutes: 3,
        category: 'tBillsBonds',
      ),
      const Lesson(
        id: '4',
        title: 'Bonds vs Stocks',
        subtitle: 'Know the difference and when to invest',
        type: 'Article',
        durationMinutes: 5,
        category: 'all',
      ),
      const Lesson(
        id: '5',
        title: 'Building Your First Portfolio',
        subtitle: 'A step-by-step guide for beginners',
        type: 'Article',
        durationMinutes: 6,
        category: 'all',
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
    final lessonData = _getLessonData(lessonId);
    if (lessonData == null) return null;

    return LessonDetail(
      id: lessonId,
      title: lessonData['title'] as String,
      date: '25th July 2025',
      durationMinutes: lessonData['duration'] as int,
      views: '20',
      hasVideo: true,
      content: lessonData['content'] as String,
      category: lessonData['category'] as String,
      comments: _getComments(),
      isRead: false,
    );
  }

  static Map<String, dynamic>? _getLessonData(String lessonId) {
    switch (lessonId) {
      case '1':
        return {
          'title': 'What is a Mutual Fund?',
          'duration': 3,
          'category': 'mutualFunds',
          'content': _getMutualFundContent(),
        };
      case '2':
        return {
          'title': 'Understanding Stocks',
          'duration': 4,
          'category': 'ghanaStocks',
          'content': _getStocksContent(),
        };
      case '3':
        return {
          'title': 'T-Bills Explained',
          'duration': 3,
          'category': 'tBillsBonds',
          'content': _getTBillsContent(),
        };
      case '4':
        return {
          'title': 'Bonds vs Stocks',
          'duration': 5,
          'category': 'all',
          'content': _getBondsArticleContent(),
        };
      case '5':
        return {
          'title': 'Building Your First Portfolio',
          'duration': 6,
          'category': 'all',
          'content': _getPortfolioContent(),
        };
      case '6':
        return {
          'title': 'Ghana Stock Exchange Basics',
          'duration': 5,
          'category': 'ghanaStocks',
          'content': _getGSEContent(),
        };
      case '7':
        return {
          'title': 'Corporate Bonds Explained',
          'duration': 6,
          'category': 'tBillsBonds',
          'content': _getCorporateBondsContent(),
        };
      case '8':
        return {
          'title': 'Diversification Strategies',
          'duration': 4,
          'category': 'all',
          'content': _getDiversificationContent(),
        };
      default:
        return null;
    }
  }

  static String _getMutualFundContent() {
    return '''
**What is a Mutual Fund?**

A mutual fund is a type of investment that pools money from many investors to purchase a diversified portfolio of stocks, bonds, or other securities. Think of it as a basket of investments managed by professionals.

**How It Works**

When you invest in a mutual fund, you're buying shares of the fund. Your money is combined with other investors' money, and a professional fund manager uses the pool to buy various investments.

**Benefits of Mutual Funds**

• **Diversification**: Your money is spread across many investments, reducing risk
• **Professional Management**: Expert fund managers make investment decisions for you
• **Accessibility**: You can start investing with relatively small amounts
• **Liquidity**: You can usually buy or sell your shares on any business day

**Types of Mutual Funds**

1. **Equity Funds**: Invest primarily in stocks
2. **Bond Funds**: Invest in government or corporate bonds
3. **Money Market Funds**: Invest in short-term, low-risk securities
4. **Balanced Funds**: Mix of stocks and bonds

**Things to Consider**

• Management fees can eat into your returns
• Past performance doesn't guarantee future results
• Understand the fund's investment strategy before investing
''';
  }

  static String _getStocksContent() {
    return '''
**Understanding Stocks**

When you buy a stock, you're purchasing a small piece of ownership in a company. As a shareholder, you have a claim on part of the company's assets and earnings.

**How Stocks Work**

Companies issue stocks to raise money for growth, operations, or other business needs. In return, investors receive shares that may increase in value and potentially pay dividends.

**Ways to Make Money from Stocks**

1. **Capital Gains**: Sell your shares for more than you paid
2. **Dividends**: Some companies share profits with shareholders through regular payments

**Key Stock Terms**

• **Share Price**: The current cost to buy one share
• **Market Cap**: Total value of all company shares
• **P/E Ratio**: Price compared to company earnings
• **Dividend Yield**: Annual dividend as a percentage of share price

**Risks to Consider**

• Stock prices can go down as well as up
• Individual company problems can affect your investment
• Market conditions impact all stocks
• No guaranteed returns

**Getting Started**

Start by researching companies you understand. Look at their financial health, growth potential, and industry position before investing.
''';
  }

  static String _getTBillsContent() {
    return '''
**T-Bills Explained**

Treasury Bills (T-Bills) are short-term government securities issued by the Bank of Ghana. They are considered one of the safest investments because they are backed by the full faith and credit of the government.

**How T-Bills Work**

T-Bills are sold at a discount to their face value. When they mature, you receive the full face value. The difference between what you paid and the face value is your return.

**Example**

If you buy a GHS 1,000 T-Bill for GHS 950, you'll receive GHS 1,000 at maturity. Your profit is GHS 50.

**Types of T-Bills in Ghana**

• **91-Day Bills**: Mature in about 3 months
• **182-Day Bills**: Mature in about 6 months
• **364-Day Bills**: Mature in about 1 year

**Benefits**

• **Safety**: Government-backed, very low risk
• **Liquidity**: Can be sold before maturity
• **Predictable Returns**: You know exactly what you'll earn
• **No Default Risk**: Government guarantees payment

**How to Invest**

You can buy T-Bills through licensed banks, investment firms, or directly at Bank of Ghana auctions. The minimum investment varies by institution.
''';
  }

  static String _getPortfolioContent() {
    return '''
**Building Your First Portfolio**

A portfolio is your collection of investments. Building a good portfolio involves selecting a mix of assets that match your goals, timeline, and risk tolerance.

**Step 1: Define Your Goals**

What are you investing for? Retirement, education, a house? Your goals determine your investment timeline and strategy.

**Step 2: Assess Your Risk Tolerance**

How would you feel if your investments dropped 20%? Understanding your comfort with risk helps you choose appropriate investments.

**Step 3: Start Simple**

For beginners, consider:
• T-Bills for safety and steady returns
• Mutual funds for diversification
• A few quality stocks for growth potential

**Step 4: Diversify**

Don't put all your eggs in one basket. Spread your money across:
• Different asset types (stocks, bonds, T-Bills)
• Different sectors (banking, telecom, consumer goods)
• Different risk levels

**Step 5: Invest Regularly**

Consistency matters more than timing. Set up regular contributions, even if small amounts.

**Step 6: Review and Rebalance**

Check your portfolio periodically. As investments grow differently, you may need to adjust to maintain your target mix.

**Common Mistakes to Avoid**

• Trying to time the market
• Investing money you might need soon
• Ignoring fees and costs
• Not diversifying enough
''';
  }

  static String _getGSEContent() {
    return '''
**Ghana Stock Exchange Basics**

The Ghana Stock Exchange (GSE) is the principal stock exchange in Ghana, located in Accra. It provides a platform for buying and selling shares of listed Ghanaian companies.

**How the GSE Works**

The GSE operates as a secondary market where investors trade shares of publicly listed companies. Trading happens Monday to Friday, excluding public holidays.

**Key Indices**

• **GSE Composite Index (GSE-CI)**: Tracks all listed stocks
• **GSE Financial Stocks Index (GSE-FSI)**: Tracks financial sector stocks

**Listed Companies**

The GSE lists companies from various sectors:
• Banking & Finance (GCB, Ecobank, CAL Bank)
• Telecommunications (MTN Ghana)
• Manufacturing & Consumer Goods
• Oil & Gas

**How to Trade**

1. Open an account with a licensed stockbroker
2. Get a Central Securities Depository (CSD) account
3. Fund your account
4. Place buy or sell orders through your broker

**Trading Costs**

• Brokerage commission
• GSE trading fee
• CSD fee
• Securities and Exchange Commission levy

**Tips for New Investors**

• Start with companies you understand
• Research before investing
• Don't invest money you can't afford to lose
• Consider both dividends and growth potential
''';
  }

  static String _getCorporateBondsContent() {
    return '''
**Corporate Bonds Explained**

Corporate bonds are debt securities issued by companies to raise capital. When you buy a corporate bond, you're essentially lending money to a company in exchange for regular interest payments and the return of your principal at maturity.

**How Corporate Bonds Work**

Companies issue bonds with:
• A face value (typically GHS 1,000 or more)
• A coupon rate (the interest rate they'll pay)
• A maturity date (when they'll repay the principal)

**Corporate vs Government Bonds**

Corporate bonds typically offer higher interest rates than government bonds because they carry more risk. If a company fails, you might not get your money back.

**Credit Ratings**

Credit rating agencies assess the likelihood that a company will repay its bonds. Higher-rated bonds are safer but pay less interest.

**Benefits**

• Higher returns than government bonds
• Regular income through coupon payments
• Can be less volatile than stocks
• Diversification for your portfolio

**Risks**

• Default risk: Company might not pay
• Interest rate risk: Bond values fall when rates rise
• Liquidity risk: Harder to sell than stocks

**Who Should Invest?**

Corporate bonds suit investors who:
• Want higher returns than T-Bills
• Can accept some credit risk
• Need regular income
• Have a medium to long-term horizon
''';
  }

  static String _getDiversificationContent() {
    return '''
**Diversification Strategies**

Diversification means spreading your investments across different assets to reduce risk. The goal is to create a portfolio where losses in one area may be offset by gains in another.

**Why Diversify?**

• Reduces the impact of any single investment performing poorly
• Smooths out returns over time
• Protects against unexpected market events
• Helps you sleep better at night

**Types of Diversification**

**1. Asset Class Diversification**
Mix different types of investments:
• Stocks for growth
• Bonds for income and stability
• T-Bills for safety
• Mutual funds for broad exposure

**2. Sector Diversification**
Invest across different industries:
• Finance
• Telecommunications
• Consumer goods
• Energy
• Healthcare

**3. Geographic Diversification**
Consider investments in different regions or countries to reduce country-specific risks.

**How Much Diversification?**

There's no magic number, but research suggests:
• 15-20 individual stocks can provide good diversification
• 3-5 different asset classes is a good start
• Avoid over-diversification which can limit returns

**Common Mistakes**

• Thinking you're diversified when you're not
• Over-concentrating in one sector
• Ignoring correlation between investments
• Diversifying too much and diluting returns

**Getting Started**

Start with a core of diversified mutual funds or ETFs, then add individual investments as you learn more.
''';
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
          const Comment(
            id: '2-2',
            authorName: 'David Chen',
            authorAvatar: '',
            text: 'I agree! The examples really made it click for me.',
            timestamp: '1d',
          ),
          const Comment(
            id: '2-3',
            authorName: 'Emma Wilson',
            authorAvatar: '',
            text: 'The quiz was challenging but fair. Learned a lot!',
            timestamp: '23h',
          ),
          const Comment(
            id: '2-4',
            authorName: 'James Martinez',
            authorAvatar: '',
            text: 'Great content! Looking forward to more lessons like this.',
            timestamp: '20h',
          ),
          const Comment(
            id: '2-5',
            authorName: 'Lisa Anderson',
            authorAvatar: '',
            text: 'This helped me understand bonds for the first time.',
            timestamp: '18h',
          ),
        ],
      ),
    ];
  }

  static Quiz? getQuiz(String lessonId) {
    // For now, provide a quiz for bonds lessons
    if (lessonId == '1' ||
        lessonId == '2' ||
        lessonId == '3' ||
        lessonId == '4') {
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
            text:
                'What is the name of the regular interest payment you receive from a bond?',
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
            text:
                'What is the name of the regular interest payment you receive from a bond?',
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
            text:
                'What is the name of the regular interest payment you receive from a bond?',
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
        assetCategory: SearchAssetCategory.stock,
        ticker: 'MTNGH',
        name: 'Scancom PLC',
        price: 4.02,
        change: 0.10,
        changePercentage: 2.3,
      ),
      SearchItem(
        id: 'h2',
        title: 'CCMF',
        type: SearchItemType.history,
        assetCategory: SearchAssetCategory.mutualFund,
        ticker: 'CCMF',
        name: 'Christian Community Mutual Fund',
        price: 1.3550,
        change: 0.17,
        changePercentage: 4.7,
      ),
      SearchItem(
        id: 'h3',
        title: 'TB 27-OCT-25',
        type: SearchItemType.history,
        assetCategory: SearchAssetCategory.tBill,
        ticker: 'TB 27-OCT-25',
        name: 'Treasury Bill',
        price: 10.83,
        change: 2.3,
        changePercentage: 2.3,
      ),
    ];
  }

  static List<SearchItem> getPopularSearches() {
    return const [
      SearchItem(
        id: 'p1',
        title: 'Stocks',
        type: SearchItemType.popular,
        assetCategory: SearchAssetCategory.generic,
      ),
      SearchItem(
        id: 'p2',
        title: 'High-Yield Funds',
        type: SearchItemType.popular,
        assetCategory: SearchAssetCategory.generic,
      ),
      SearchItem(
        id: 'p3',
        title: 'T-Bills',
        type: SearchItemType.popular,
        assetCategory: SearchAssetCategory.generic,
      ),
    ];
  }

  static List<String> getStockLevels() {
    return ['All Stocks', 'Blue Chip', 'Mid Cap', 'Small Cap'];
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

  /// Get all searchable lessons as SearchItem list
  static List<SearchItem> getAllSearchableLessons() {
    final lessons = getLessons();
    return lessons.map((lesson) {
      return SearchItem(
        id: lesson.id,
        title: lesson.title,
        type: SearchItemType.popular,
        assetCategory: SearchAssetCategory.lesson,
        name: lesson.subtitle,
      );
    }).toList();
  }

  /// Get lesson search history
  static List<SearchItem> getLessonSearchHistory() {
    return const [
      SearchItem(
        id: '1',
        title: 'What is a Mutual Fund?',
        type: SearchItemType.history,
        assetCategory: SearchAssetCategory.lesson,
        name: 'Pooling money, spreading risk, growing wealth',
      ),
      SearchItem(
        id: '3',
        title: 'T-Bills Explained',
        type: SearchItemType.history,
        assetCategory: SearchAssetCategory.lesson,
        name: 'Low risk, guaranteed returns, government backed',
      ),
    ];
  }

  /// Get popular lesson searches
  static List<SearchItem> getPopularLessonSearches() {
    return const [
      SearchItem(
        id: '2',
        title: 'Understanding Stocks',
        type: SearchItemType.popular,
        assetCategory: SearchAssetCategory.lesson,
        name: 'Own a piece of your favorite companies',
      ),
      SearchItem(
        id: '5',
        title: 'Building Your First Portfolio',
        type: SearchItemType.popular,
        assetCategory: SearchAssetCategory.lesson,
        name: 'A step-by-step guide for beginners',
      ),
    ];
  }
}
