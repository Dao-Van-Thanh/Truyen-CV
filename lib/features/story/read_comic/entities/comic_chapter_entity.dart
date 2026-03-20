import 'package:truyen_cv/dependency/local_api/repository/book/entities/list_chapter_entity.dart';

class ComicChapterEntity extends ListChapterEntity {
  final List<ComicPageEntity> pages;

  ComicChapterEntity({
    required super.id,
    required super.name,
    required this.pages,
  });

  ComicChapterEntity copyWith({
    String? id,
    String? name,
    List<ComicPageEntity>? pages,
  }) {
    return ComicChapterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      pages: pages ?? this.pages,
    );
  }

  @override
  String toString() =>
      'ComicChapterEntity(id: $id, name: $name, pagesCount: ${pages.length})';
}

class ComicPageEntity {
  final int index;
  final String url;

  ComicPageEntity({
    required this.index,
    required this.url,
  });

  ComicPageEntity copyWith({
    int? index,
    String? url,
  }) {
    return ComicPageEntity(
      index: index ?? this.index,
      url: url ?? this.url,
    );
  }

  @override
  String toString() => 'ComicPageEntity(index: $index, url: $url)';
}

extension ComicChapterEntityExtension on ComicChapterEntity {
  ListChapterEntity toListChapterEntity() =>
      ListChapterEntity(id: id, name: name);
}
