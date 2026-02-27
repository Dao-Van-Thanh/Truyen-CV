class ListComicCategoryRes {
  final List<CategoryComicItemModel>? items;

  ListComicCategoryRes({this.items});

  factory ListComicCategoryRes.fromJson(Map<String, dynamic> json) {
    return ListComicCategoryRes(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => CategoryComicItemModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items?.map((e) => e.toJson()).toList(),
    };
  }
}

class CategoryComicItemModel {
  final String? slug;
  final String? name;

  CategoryComicItemModel({
    this.slug,
    this.name,
  });

  factory CategoryComicItemModel.fromJson(Map<String, dynamic> json) {
    return CategoryComicItemModel(
      slug: json['slug'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slug': slug,
      'name': name,
    };
  }
}
