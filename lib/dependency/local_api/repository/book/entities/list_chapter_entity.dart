import 'package:truyen_cv/shared/utilities/map.dart';

class ListChapterEntity {
  final String id;
  final String name;

  ListChapterEntity({
    required this.id,
    required this.name,
  });

  factory ListChapterEntity.fromJson(Map<String, dynamic> json) {
    final jsonLowCase = MapUtil.convertKeysToLowerCase(json);
    return ListChapterEntity(
      id: jsonLowCase['id'] as String,
      name: jsonLowCase['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListChapterEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ name.hashCode;

  @override
  String toString() => 'ListChapterEntity(id: $id, name: $name)';
}
