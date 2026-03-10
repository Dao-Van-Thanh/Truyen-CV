import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/features/counter/counter_bloc.dart';
import 'package:flutter_template/features/explore/category/explore_category_bloc.dart';
import 'package:flutter_template/features/explore/comic/explore_comic_bloc.dart';
import 'package:flutter_template/features/explore/explore_bloc.dart';
import 'package:flutter_template/features/explore/novel/explore_novel_bloc.dart';
import 'package:flutter_template/features/individual/backup/backup_bloc.dart';
import 'package:flutter_template/features/individual/individual_bloc.dart';
import 'package:flutter_template/features/individual/setting/setting_bloc.dart';
import 'package:flutter_template/features/library/library_bloc.dart';
import 'package:flutter_template/features/root/root_bloc.dart';
import 'package:flutter_template/features/story/detail/story_detail_bloc.dart';
import 'package:flutter_template/features/story/list_chapter/list_chapter_bloc.dart';
import 'package:flutter_template/features/story/read_comic/read_comic_bloc.dart';
import 'package:flutter_template/features/story/read_story/read_story_bloc.dart';
import 'package:flutter_template/features/story/search/story_search_bloc.dart';
import 'package:flutter_template/shared/bloc/app_bloc.dart';
import 'package:flutter_template/shared/bloc/config/app_config_bloc.dart';

class BlocProvider {
  static final app = Provider((ref) => AppBloc(ref));
  static final config = Provider((ref) => AppConfigBloc(ref));
  static late AutoDisposeProvider<CounterBloc> counter;
  static late AutoDisposeProvider<RootBloc> root;
  static late AutoDisposeProvider<LibraryBloc> library;
  static late AutoDisposeProvider<IndividualBloc> individual;
  static late AutoDisposeProvider<ExploreBloc> explore;
  static late AutoDisposeProvider<StoryDetailBloc> storyDetail;
  static late AutoDisposeProvider<ListChapterBloc> listChapter;
  static late AutoDisposeProvider<ReadStoryBloc> readStory;
  static late AutoDisposeProvider<StorySearchBloc> storySearch;
  static late AutoDisposeProvider<SettingBloc> setting;

  static late AutoDisposeProvider<ExploreNovelBloc> exploreNovel;
  static late AutoDisposeProvider<ExploreComicBloc> exploreComic;
  static late AutoDisposeProvider<ExploreCategoryBloc> exploreCategory;
  static late AutoDisposeProvider<BackupBloc> backup;
  static late AutoDisposeProvider<ReadComicBloc> readComic;

  const BlocProvider._();
}
