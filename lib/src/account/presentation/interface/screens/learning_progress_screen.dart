import 'package:flutter/material.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../../learn/data/dummy_learn_data.dart';
import '../../../../learn/domain/entities/lesson.dart';
import '../../../../learn/presentation/interface/screens/lesson_detail_screen.dart';
import '../widgets/learning_progress_card.dart';

class LearningProgressScreen extends StatefulWidget {
  const LearningProgressScreen({super.key});

  @override
  State<LearningProgressScreen> createState() => _LearningProgressScreenState();
}

class _LearningProgressScreenState extends State<LearningProgressScreen> {
  int _selectedTabIndex = 0;

  List<Lesson> get _lessons => DummyLearnData.getLessons();

  LearningProgressTab get _currentTab {
    switch (_selectedTabIndex) {
      case 0:
        return LearningProgressTab.inProgress;
      case 1:
        return LearningProgressTab.saved;
      case 2:
        return LearningProgressTab.completed;
      default:
        return LearningProgressTab.inProgress;
    }
  }

  int _getCompletedTracks(int index) {
    switch (_selectedTabIndex) {
      case 0:
        return (index % 3) + 1;
      case 1:
        return 0;
      case 2:
        return 4;
      default:
        return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.learningProgress,
        showBottomDivider: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: _TabBar(
              selectedIndex: _selectedTabIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedTabIndex = index;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _lessons.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final lesson = _lessons[index];
                return LearningProgressCard(
                  lesson: lesson,
                  tab: _currentTab,
                  isSaved: _selectedTabIndex == 1,
                  completedTracks: _getCompletedTracks(index),
                  totalTracks: 4,
                  onTap: () {
                    NavigationHelper.navigateTo(
                      context,
                      LessonDetailScreen(lessonId: lesson.id),
                    );
                  },
                  onBookmarkTap: () {
                    // TODO: Toggle bookmark
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const _TabBar({required this.selectedIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      context.localize.inProgress,
      context.localize.saved,
      context.localize.completed,
    ];

    return Row(
      children: List.generate(tabs.length, (index) {
        final isSelected = selectedIndex == index;
        return Expanded(
          child: GestureDetector(
            onTap: () => onTabSelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected
                        ? AppColors.appPrimary
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
              child: Center(
                child: AppText.smaller(
                  tabs[index],
                  style: TextStyle(
                    color: isSelected
                        ? AppColors.appPrimary
                        : AppColors.secondaryText(context),
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
