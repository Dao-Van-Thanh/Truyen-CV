import 'package:flutter/material.dart';
import 'package:flutter_template/i18n/strings.g.dart';

enum ExploreEnum {
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
  const ExploreEnum({required this.page});
}

extension ExploreEnumExtension on ExploreEnum {
  String label(BuildContext context) {
    final t = context.t;
    switch (this) {
      case ExploreEnum.newlyUpdated:
        return t.exploreScreen.pages.newlyUpdated;
      case ExploreEnum.newlyPostedStory:
        return t.exploreScreen.pages.newlyPostedStory;
      case ExploreEnum.allTimeReads:
        return t.exploreScreen.pages.allTimeReads;
      case ExploreEnum.monthlyReads:
        return t.exploreScreen.pages.monthlyReads;
      case ExploreEnum.weeklyReads:
        return t.exploreScreen.pages.weeklyReads;
      case ExploreEnum.dailyReads:
        return t.exploreScreen.pages.dailyReads;
      case ExploreEnum.allTimeNominations:
        return t.exploreScreen.pages.allTimeNominations;
      case ExploreEnum.monthlyNominations:
        return t.exploreScreen.pages.monthlyNominations;
      case ExploreEnum.voteScore:
        return t.exploreScreen.pages.voteScore;
      case ExploreEnum.chapterCount:
        return t.exploreScreen.pages.chapterCount;
      case ExploreEnum.genres:
        return t.exploreScreen.pages.genre;
    }
  }
}
