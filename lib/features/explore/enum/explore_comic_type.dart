import 'package:flutter_template/i18n/strings.g.dart';

enum ExploreComicType {
  newRelease,
  upcoming,
  ongoing,
  completed,
  genres;
}

extension ExploreComicTypeExtension on ExploreComicType {
  String get slug {
    switch (this) {
      case ExploreComicType.newRelease:
        return 'truyen-moi';
      case ExploreComicType.upcoming:
        return 'sap-ra-mat';
      case ExploreComicType.ongoing:
        return 'dang-phat-hanh';
      case ExploreComicType.completed:
        return 'hoan-thanh';
      case ExploreComicType.genres:
        return 'the-loai';
    }
  }

  String get displayName {
    switch (this) {
      case ExploreComicType.newRelease:
        return t.comic.type.newRelease;
      case ExploreComicType.upcoming:
        return t.comic.type.upcoming;
      case ExploreComicType.ongoing:
        return t.comic.type.ongoing;
      case ExploreComicType.completed:
        return t.comic.type.completed;
      case ExploreComicType.genres:
        return t.comic.type.genres;
    }
  }
}
