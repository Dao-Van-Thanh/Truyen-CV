import 'package:flutter_template/dependency/router/arguments/explore_argument.dart';
import 'package:flutter_template/dependency/router/arguments/list_chapter_argument.dart';
import 'package:flutter_template/dependency/router/arguments/read_story_argument.dart';

import 'package:flutter_template/dependency/router/utils/route_name.dart';

class RouteInput {
  String routeName;
  Object? arguments;

  RouteInput({
    required this.routeName,
    this.arguments,
  });

  RouteInput.counter() : routeName = RouteName.counter;
  RouteInput.root() : routeName = RouteName.root;
  RouteInput.unknown() : routeName = RouteName.unknown;
  RouteInput.library() : routeName = RouteName.library;
  RouteInput.explore({
    ExploreArgument? this.arguments,
  }) : routeName = RouteName.explore;
  RouteInput.individual() : routeName = RouteName.individual;
  RouteInput.storyDetail({
    required String storyId,
  })  : routeName = RouteName.storyDetail,
        arguments = storyId;

  RouteInput.listChapter({
    required ListChapterArgument args,
  })  : routeName = RouteName.listChapter,
        arguments = args;

  RouteInput.readStory({
    required ReadStoryArgument args,
  })  : routeName = RouteName.readStory,
        arguments = args;

  RouteInput.storySearch() : routeName = RouteName.storySearch;
}
