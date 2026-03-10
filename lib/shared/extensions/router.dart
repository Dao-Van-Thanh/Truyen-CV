import 'package:flutter_template/dependency/local_api/repository/book/enum/story_type.dart';
import 'package:flutter_template/dependency/router/arguments/read_comic_argument.dart';
import 'package:flutter_template/dependency/router/arguments/read_story_argument.dart';
import 'package:flutter_template/dependency/router/router_service.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/features/story/read_comic/entities/comic_chapter_entity.dart';

extension RouterExtension on RouterService {
  Future<Object?> pushReadStory(
    StoryType type, {
    required ReadStoryArgument args,
  }) async {
    switch (type) {
      case StoryType.novel:
        return push(
          RouteInput.readStory(
            args: args,
          ),
        );
      case StoryType.comic:
        return push(
          RouteInput.readComic(
            args: ReadComicArgument(
              storyId: args.storyId,
              selectedChapterId: args.selectedChapterId,
              listChapter: args.listChapter.map((e) {
                return ComicChapterEntity(id: e.id, name: e.name, pages: []);
              }).toList(),
              scrollOffset: args.scrollOffset,
            ),
          ),
        );
    }
  }
}
