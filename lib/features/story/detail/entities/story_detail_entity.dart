import 'package:flutter_template/dependency/local_api/repository/book/entities/list_chapter_entity.dart';
import 'package:flutter_template/dependency/local_api/repository/book/enum/story_type.dart';

class StoryDetailEntity {
  final String id;
  final String name;
  final String totalChapter;
  final String? cat;
  final String? author;
  final String? trans;
  final String desc;
  final String thumb;
  final StoryType type;
  final List<ListChapterEntity> listChapter;

  StoryDetailEntity({
    required this.id,
    required this.name,
    required this.totalChapter,
    this.cat,
    this.author,
    this.trans,
    required this.desc,
    required this.thumb,
    required this.type,
    required this.listChapter,
  });

  factory StoryDetailEntity.fromJson(Map<String, dynamic> json) {
    return StoryDetailEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      totalChapter: json['totalChapter'] as String,
      cat: json['cat'] as String?,
      author: json['author'] as String?,
      trans: json['trans'] as String?,
      desc: json['desc'] as String,
      thumb: json['thumb'] as String? ?? '',
      type: StoryType.fromString(json['type'] as String?),
      listChapter: (json['listChapter'] as List<dynamic>)
          .map((e) => ListChapterEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'totalChapter': totalChapter,
      'cat': cat,
      'author': author,
      'trans': trans,
      'desc': desc,
      'thumb': thumb,
      'type': type.name,
      'listChapter': listChapter.map((e) => e.toJson()).toList(),
    };
  }

  StoryDetailEntity copyWith({
    String? id,
    String? name,
    String? totalChapter,
    String? cat,
    String? author,
    String? trans,
    String? desc,
    String? thumb,
    StoryType? type,
    List<ListChapterEntity>? listChapter,
  }) {
    return StoryDetailEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      totalChapter: totalChapter ?? this.totalChapter,
      cat: cat ?? this.cat,
      author: author ?? this.author,
      trans: trans ?? this.trans,
      desc: desc ?? this.desc,
      thumb: thumb ?? this.thumb,
      type: type ?? this.type,
      listChapter: listChapter ?? this.listChapter,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StoryDetailEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          type == other.type &&
          listChapter.length == other.listChapter.length;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ type.hashCode ^ listChapter.length.hashCode;

  @override
  String toString() =>
      'StoryDetailEntity(id: $id, name: $name, type: ${type.name}, totalChapter: $totalChapter, cat: $cat, author: $author, trans: $trans, thumb: $thumb, listChapter: ${listChapter.length} chapters)';
}
