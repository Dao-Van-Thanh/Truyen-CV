import 'package:flutter/material.dart';
import 'package:truyen_cv/bloc/bloc_base.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/dependency/router/arguments/explore_category_argument.dart';
import 'package:truyen_cv/dependency/router/arguments/list_chapter_argument.dart';
import 'package:truyen_cv/dependency/router/arguments/read_comic_argument.dart';
import 'package:truyen_cv/dependency/router/arguments/read_story_argument.dart';
import 'package:truyen_cv/dependency/router/arguments/story_detail_argument.dart';
import 'package:truyen_cv/dependency/router/arguments/story_search_argument.dart';
import 'package:truyen_cv/features/counter/counter_bloc.dart';
import 'package:truyen_cv/features/counter/counter_screen.dart';
import 'package:truyen_cv/features/explore/category/explore_category_bloc.dart';
import 'package:truyen_cv/features/explore/category/explore_category_screen.dart';
import 'package:truyen_cv/features/explore/comic/explore_comic_bloc.dart';
import 'package:truyen_cv/features/explore/comic/explore_comic_screen.dart';
import 'package:truyen_cv/features/explore/explore_bloc.dart';
import 'package:truyen_cv/features/explore/explore_screen.dart';
import 'package:truyen_cv/features/explore/novel/explore_novel_bloc.dart';
import 'package:truyen_cv/features/explore/novel/explore_novel_screen.dart';
import 'package:truyen_cv/features/individual/backup/backup_bloc.dart';
import 'package:truyen_cv/features/individual/backup/backup_screen.dart';
import 'package:truyen_cv/features/individual/individual_bloc.dart';
import 'package:truyen_cv/features/individual/individual_screen.dart';
import 'package:truyen_cv/features/individual/setting/setting_bloc.dart';
import 'package:truyen_cv/features/individual/setting/setting_screen.dart';
import 'package:truyen_cv/features/library/library_bloc.dart';
import 'package:truyen_cv/features/library/library_screen.dart';
import 'package:truyen_cv/features/root/root_bloc.dart';
import 'package:truyen_cv/features/root/root_screen.dart';
import 'package:truyen_cv/features/story/detail/story_detail_bloc.dart';
import 'package:truyen_cv/features/story/detail/story_detail_screen.dart';
import 'package:truyen_cv/features/story/list_chapter/list_chapter_bloc.dart';
import 'package:truyen_cv/features/story/list_chapter/list_chapter_screen.dart';
import 'package:truyen_cv/features/story/read_comic/read_comic_bloc.dart';
import 'package:truyen_cv/features/story/read_comic/read_comic_screen.dart';
import 'package:truyen_cv/features/story/read_story/read_story_bloc.dart';
import 'package:truyen_cv/features/story/read_story/read_story_screen.dart';
import 'package:truyen_cv/features/story/search/story_search_bloc.dart';
import 'package:truyen_cv/features/story/search/story_search_screen.dart';
import 'package:truyen_cv/features/unknown/unknown_screen.dart';

class RouteScreen {
  static PageRoute counterPageRoute(RouteSettings settings) {
    BlocProvider.counter = createAutoDisposeBloc(
      (ref) => CounterBloc(ref),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const CounterScreen(),
    );
  }

  static PageRoute rootPageRoute(RouteSettings settings) {
    BlocProvider.root = createAutoDisposeBloc(
      (ref) => RootBloc(ref),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const RootScreen(),
    );
  }

  static PageRoute unknownPageRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const UnknownScreen(),
    );
  }

  static PageRoute libraryPageRoute(RouteSettings settings) {
    BlocProvider.library = createAutoDisposeBloc(
      (ref) => LibraryBloc(ref),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const LibraryScreen(),
    );
  }

  static PageRoute explorePageRoute(RouteSettings settings) {
    BlocProvider.explore = createAutoDisposeBloc(
      (ref) => ExploreBloc(ref),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const ExploreScreen(),
    );
  }

  static PageRoute individualPageRoute(RouteSettings settings) {
    BlocProvider.individual = createAutoDisposeBloc(
      (ref) => IndividualBloc(ref),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const IndividualScreen(),
    );
  }

  static PageRoute storyDetailPageRoute(RouteSettings settings) {
    final args = settings.arguments as StoryDetailArgument;
    BlocProvider.storyDetail = createAutoDisposeBloc(
      (ref) => StoryDetailBloc(ref, args: args),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const StoryDetailScreen(),
    );
  }

  static PageRoute listChapterPageRoute(RouteSettings settings) {
    final args = settings.arguments as ListChapterArgument;
    BlocProvider.listChapter = createAutoDisposeBloc(
      (ref) => ListChapterBloc(ref, args: args),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const ListChapterScreen(),
    );
  }

  static PageRoute readStoryPageRoute(RouteSettings settings) {
    final args = settings.arguments as ReadStoryArgument;
    BlocProvider.readStory = createAutoDisposeBloc(
      (ref) => ReadStoryBloc(ref, args: args),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const ReadStoryScreen(),
    );
  }

  static PageRoute storySearchPageRoute(RouteSettings settings) {
    final args = settings.arguments as StorySearchArgument;
    BlocProvider.storySearch = createAutoDisposeBloc(
      (ref) => StorySearchBloc(ref, args: args),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const StorySearchScreen(),
    );
  }

  static PageRoute settingPageRoute(RouteSettings settings) {
    BlocProvider.setting = createAutoDisposeBloc(
      (ref) => SettingBloc(ref),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const SettingScreen(),
    );
  }

  static PageRoute exploreNovelPageRoute(RouteSettings settings) {
    BlocProvider.exploreNovel = createAutoDisposeBloc(
      (ref) => ExploreNovelBloc(ref),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const ExploreNovelScreen(),
    );
  }

  static PageRoute exploreComicPageRoute(RouteSettings settings) {
    BlocProvider.exploreComic = createAutoDisposeBloc(
      (ref) => ExploreComicBloc(ref),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const ExploreComicScreen(),
    );
  }

  static PageRoute exploreCategoryPageRoute(RouteSettings settings) {
    final args = settings.arguments as ExploreCategoryArgument;
    BlocProvider.exploreCategory = createAutoDisposeBloc(
      (ref) => ExploreCategoryBloc(ref, args: args),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const ExploreCategoryScreen(),
    );
  }

  static PageRoute backupPageRoute(RouteSettings settings) {
    BlocProvider.backup = createAutoDisposeBloc(
      (ref) => BackupBloc(ref),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const BackupScreen(),
    );
  }

  static PageRoute readComicPageRoute(RouteSettings settings) {
    final args = settings.arguments as ReadComicArgument;
    BlocProvider.readComic = createAutoDisposeBloc(
      (ref) => ReadComicBloc(ref, args: args),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const ReadComicScreen(),
    );
  }
}
