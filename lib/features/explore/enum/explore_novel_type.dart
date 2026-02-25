import 'package:flutter/material.dart';
import 'package:flutter_template/i18n/strings.g.dart';

enum ExploreNovelType {
  newlyUpdated(page: 0),
  newlyPostedStory(page: 1),
  allTimeReads(page: 2),
  monthlyReads(page: 3),
  weeklyReads(page: 4),
  dailyReads(page: 5),
  allTimeNominations(page: 6),
  monthlyNominations(page: 7),
  voteScore(page: 8),
  chapterCount(page: 9),
  genres(page: -1);

  final int page;
  const ExploreNovelType({required this.page});
}

extension ExploreNovelTypeExtension on ExploreNovelType {
  String label(BuildContext context) {
    final t = context.t;
    switch (this) {
      case ExploreNovelType.newlyUpdated:
        return t.exploreScreen.pages.newlyUpdated;
      case ExploreNovelType.newlyPostedStory:
        return t.exploreScreen.pages.newlyPostedStory;
      case ExploreNovelType.allTimeReads:
        return t.exploreScreen.pages.allTimeReads;
      case ExploreNovelType.monthlyReads:
        return t.exploreScreen.pages.monthlyReads;
      case ExploreNovelType.weeklyReads:
        return t.exploreScreen.pages.weeklyReads;
      case ExploreNovelType.dailyReads:
        return t.exploreScreen.pages.dailyReads;
      case ExploreNovelType.allTimeNominations:
        return t.exploreScreen.pages.allTimeNominations;
      case ExploreNovelType.monthlyNominations:
        return t.exploreScreen.pages.monthlyNominations;
      case ExploreNovelType.voteScore:
        return t.exploreScreen.pages.voteScore;
      case ExploreNovelType.chapterCount:
        return t.exploreScreen.pages.chapterCount;
      case ExploreNovelType.genres:
        return t.exploreScreen.pages.genre;
    }
  }
}
