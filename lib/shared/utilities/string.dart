class StringUtilities {
  static String clearHtml(String input) {
    String parsedString = input.replaceAll(RegExp(r'<br\s*/?>\s*'), '\n');

    parsedString = parsedString.replaceAll('\t', '');
    parsedString = parsedString.replaceAll(RegExp(r'\n{3,}'), '\n\n');
    parsedString = parsedString.replaceAll(RegExp('\n\n'), '\n');
    return parsedString.trim();
  }

  const StringUtilities._();
}
