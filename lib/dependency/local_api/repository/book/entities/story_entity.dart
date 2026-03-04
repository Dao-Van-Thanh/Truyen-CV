import 'package:flutter_template/dependency/local_api/repository/book/enum/story_type.dart';
import 'package:flutter_template/shared/utilities/map.dart';

class StoryEntity {
  final String id;
  final String name;
  final String thumb;
  final String process; // last chapter update
  final String? author;
  final String? viewed;
  final double? rating;
  final StoryType storyType;

  const StoryEntity({
    required this.id,
    required this.name,
    required this.thumb,
    required this.process,
    this.author,
    this.viewed,
    this.rating,
    required this.storyType,
  });

  factory StoryEntity.empty() {
    return StoryEntity(
      id: '',
      name: '',
      thumb: '',
      process: '',
      author: '',
      viewed: '',
      rating: 0.0,
      storyType: StoryType.values.first,
    );
  }

  factory StoryEntity.fromJson(Map<String, dynamic> json) {
    final jsonLowCase = MapUtil.convertKeysToLowerCase(json);
    return StoryEntity(
      id: jsonLowCase['id'] as String? ?? '',
      name: jsonLowCase['name'] as String? ?? '',
      thumb: jsonLowCase['thumb'] as String? ?? '',
      process: jsonLowCase['process'] as String? ?? '',
      author: jsonLowCase['author'] as String?,
      viewed: jsonLowCase['viewed'] as String?,
      rating: (jsonLowCase['rating'] as num?)?.toDouble(),
      storyType:
          StoryType.fromString(jsonLowCase['storyType'] as String? ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'thumb': thumb,
      'process': process,
      'author': author,
      'viewed': viewed,
      'rating': rating,
      'storyType': storyType.name,
    };
  }

  StoryEntity copyWith({
    String? id,
    String? name,
    String? thumb,
    String? process,
    String? author,
    String? viewed,
    double? rating,
    StoryType? storyType,
  }) {
    return StoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      thumb: thumb ?? this.thumb,
      process: process ?? this.process,
      author: author ?? this.author,
      viewed: viewed ?? this.viewed,
      rating: rating ?? this.rating,
      storyType: storyType ?? this.storyType,
    );
  }

  @override
  String toString() {
    return '''StoryEntity(
  id: $id,
  name: $name,
  thumb: $thumb,
  process: $process,
  author: $author,
  viewed: $viewed,
  rating: $rating,
  storyType: $storyType,
)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StoryEntity &&
        other.id == id &&
        other.name == name &&
        other.thumb == thumb &&
        other.process == process &&
        other.author == author &&
        other.viewed == viewed &&
        other.rating == rating &&
        other.storyType == storyType;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        thumb.hashCode ^
        process.hashCode ^
        author.hashCode ^
        viewed.hashCode ^
        rating.hashCode ^
        storyType.hashCode;
  }
}
