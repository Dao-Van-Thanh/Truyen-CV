enum StoryType {
  novel('novel'),
  comic('comic');

  final String slug;

  const StoryType(this.slug);

  factory StoryType.fromString(String slug) {
    return StoryType.values.firstWhere(
      (e) => e.slug == slug,
      orElse: () => StoryType.novel,
    );
  }
}
