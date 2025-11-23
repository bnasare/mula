import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

import '../../../../../shared/presentation/theme/app_colors.dart';
import '../../../../../shared/presentation/widgets/constants/app_spacer.dart';
import '../../../../../shared/presentation/widgets/constants/app_text.dart';
import '../../../../../shared/presentation/widgets/mula_app_bar.dart';
import '../../../../../shared/utils/localization_extension.dart';
import '../../../../../shared/utils/navigation.dart';
import '../../../data/dummy_learn_data.dart';
import '../widgets/featured_track_card.dart';
import '../widgets/lesson_card.dart';
import '../widgets/track_filter_tabs.dart';
import 'learn_search_screen.dart';
import 'lesson_detail_screen.dart';

/// Learn tab - Educational content for investment learning
class LearnTab extends StatefulWidget {
  const LearnTab({super.key});

  @override
  State<LearnTab> createState() => _LearnTabState();
}

class _LearnTabState extends State<LearnTab> {
  String _selectedCategory = 'all';

  @override
  Widget build(BuildContext context) {
    final featuredTracks = DummyLearnData.getFeaturedTracks();
    final lessons = DummyLearnData.getLessons(category: _selectedCategory);

    return Scaffold(
      appBar: MulaAppBar(
        title: context.localize.learningTracks,
        centerTitle: false,
        showBackButton: false,
        actions: [
          IconButton(
            icon: Icon(
              IconlyLight.search,
              color: AppColors.primaryText(context),
            ),
            onPressed: () {
              NavigationHelper.navigateTo(context, const LearnSearchScreen());
            },
          ),
        ],
      ),
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: CustomScrollView(
          slivers: [
            // Filter tabs
            SliverToBoxAdapter(
              child: Column(
                children: [
                  AppSpacer.vLarge(),
                  TrackFilterTabs(
                    selectedCategory: _selectedCategory,
                    onCategorySelected: (category) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                  ),
                  AppSpacer.vLarge(),
                ],
              ),
            ),

            // Featured Tracks Section
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppText.medium(
                      context.localize.featuredTracks,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  AppSpacer.vShort(),
                  SizedBox(
                    height: 114,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      primary: false,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: featuredTracks.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        return FeaturedTrackCard(
                          track: featuredTracks[index],
                          onTap: () {
                            NavigationHelper.navigateTo(
                              context,
                              LessonDetailScreen(
                                lessonId: featuredTracks[index].id,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  AppSpacer.vLarger(),
                ],
              ),
            ),

            // Popular Lessons Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppText.medium(
                  context.localize.popularLessons,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),

            SliverToBoxAdapter(child: AppSpacer.vShorter()),

            // Lessons List
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return LessonCard(lesson: lessons[index]);
              }, childCount: lessons.length),
            ),

            // Bottom spacing
            SliverToBoxAdapter(child: AppSpacer.vLarger()),
          ],
        ),
      ),
    );
  }
}
