import 'package:flutter_template/shared/utilities/map.dart';

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
}
