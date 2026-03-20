import 'package:truyen_cv/shared/utilities/map.dart';

class StoryEntity {
  final String id;
  final String name;
  final String thumb;
  final String process; // last chapter update
  final String? author;
  final String? viewed;
  final double? rating;

  const StoryEntity({
    required this.id,
    required this.name,
    required this.thumb,
    required this.process,
    this.author,
    this.viewed,
    this.rating,
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
  }) {
    return StoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      thumb: thumb ?? this.thumb,
      process: process ?? this.process,
      author: author ?? this.author,
      viewed: viewed ?? this.viewed,
      rating: rating ?? this.rating,
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
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        thumb.hashCode ^
        process.hashCode ^
        author.hashCode ^
        viewed.hashCode ^
        rating.hashCode;
  }
}
