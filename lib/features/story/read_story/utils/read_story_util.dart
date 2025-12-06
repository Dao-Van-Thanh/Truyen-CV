class ReadStoryUtil {
  static List<String> parseContent(String content, String? chapterName) {
    final pTagRegExp = RegExp(r'<p>(.*?)</p>');

    String processedContent = content;

    if (pTagRegExp.hasMatch(content)) {
      processedContent = content.replaceFirstMapped(
        pTagRegExp,
        (match) => '<p>${chapterName ?? "Chương Mới"}</p>\n',
      );
    } else {
      processedContent = '<p>${chapterName ?? "Chương Mới"}</p>\n$content';
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
