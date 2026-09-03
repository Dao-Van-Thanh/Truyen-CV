import 'package:html_unescape/html_unescape.dart';

class ReadStoryUtil {
  static final HtmlUnescape _htmlUnescape = HtmlUnescape();

  static String _cleanChapterName(String? name) {
    if (name == null) return 'Chương';
    return _decodeHtmlEntities(
      name.replaceAll(RegExp(r'\s*\(#\d+\)$'), ''),
    );
  }

  static String _decodeHtmlEntities(String text) {
    return _htmlUnescape.convert(text).replaceAll('\u00A0', ' ').trim();
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
          final cleanLine = _decodeHtmlEntities(e);
          return cleanLine;
        })
        .where((e) => e.isNotEmpty)
        .toList();
  }

  const ReadStoryUtil._();
}
