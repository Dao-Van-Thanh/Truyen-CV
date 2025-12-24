import 'package:flutter/material.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/dependency/router/arguments/explore_argument.dart';
import 'package:flutter_template/dependency/router/arguments/list_chapter_argument.dart';
import 'package:flutter_template/dependency/router/arguments/read_story_argument.dart';
import 'package:flutter_template/features/counter/counter_bloc.dart';
import 'package:flutter_template/features/counter/counter_screen.dart';
import 'package:flutter_template/features/explore/explore_bloc.dart';
import 'package:flutter_template/features/explore/explore_screen.dart';
import 'package:flutter_template/features/individual/individual_bloc.dart';
import 'package:flutter_template/features/individual/individual_screen.dart';
import 'package:flutter_template/features/library/library_bloc.dart';
import 'package:flutter_template/features/library/library_screen.dart';
import 'package:flutter_template/features/root/root_bloc.dart';
import 'package:flutter_template/features/root/root_screen.dart';
import 'package:flutter_template/features/story/detail/story_detail_bloc.dart';
import 'package:flutter_template/features/story/detail/story_detail_screen.dart';
import 'package:flutter_template/features/story/list_chapter/list_chapter_bloc.dart';
import 'package:flutter_template/features/story/list_chapter/list_chapter_screen.dart';
import 'package:flutter_template/features/story/read_story/read_story_bloc.dart';
import 'package:flutter_template/features/story/read_story/read_story_screen.dart';
import 'package:flutter_template/features/story/search/story_search_bloc.dart';
import 'package:flutter_template/features/story/search/story_search_screen.dart';
import 'package:flutter_template/features/unknown/unknown_screen.dart';

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
    final args = settings.arguments as ExploreArgument?;
    BlocProvider.explore = createAutoDisposeBloc(
      (ref) => ExploreBloc(ref, args: args),
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
    final args = settings.arguments as String;
    BlocProvider.storyDetail = createAutoDisposeBloc(
      (ref) => StoryDetailBloc(ref, storyId: args),
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
    BlocProvider.storySearch = createAutoDisposeBloc(
      (ref) => StorySearchBloc(ref),
    );
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => const StorySearchScreen(),
    );
  }
}
