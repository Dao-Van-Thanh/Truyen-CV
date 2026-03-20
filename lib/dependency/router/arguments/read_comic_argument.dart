import 'package:truyen_cv/features/story/read_comic/entities/comic_chapter_entity.dart';

class ReadComicArgument {
  final String storyId;
  final String selectedChapterId;
  final double scrollOffset;
  final List<ComicChapterEntity> listChapter;

  ReadComicArgument({
    required this.storyId,
    required this.selectedChapterId,
    required this.listChapter,
    required this.scrollOffset,
  });
}
