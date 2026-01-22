class ReadStoryUtil {
  static String _cleanChapterName(String? name) {
    if (name == null) return 'Chương';
    return name.replaceAll(RegExp(r'\s*\(#\d+\)$'), '');
  }

  static List<String> parseContent(String content, String? chapterName) {
    final pTagRegExp = RegExp(r'<p>(.*?)</p>');
    final cleanChapterName = _cleanChapterName(chapterName);

    String processedContent = content;

    if (pTagRegExp.hasMatch(content)) {
      processedContent = content.replaceFirstMapped(
        pTagRegExp,
        (match) => '<p>${cleanChapterName}</p>\n',
      );
    } else {
      processedContent = '<p>${cleanChapterName}</p>\n$content';
    }

    final splitRegExp = RegExp(r'(<br\s*\/?>|<p>|<\/p>)');

    final rawParts = processedContent.split(splitRegExp);

    return rawParts
        .map((e) {
          final cleanLine = e.trim();
          return cleanLine;
        })
        .where((e) => e.isNotEmpty)
        .toList();
  }

  const ReadStoryUtil._();
}
