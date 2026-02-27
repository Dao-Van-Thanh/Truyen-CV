enum StoryType {
  novel('0'),
  comic('1');

  final String value;

  const StoryType(this.value);

  factory StoryType.fromString(String value) {
    return StoryType.values.firstWhere(
      (e) => e.value == value,
      orElse: () => StoryType.novel,
    );
  }
}
