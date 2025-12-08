class StringUtilities {
  static String clearHtml(String input) {
    String parsedString = input.replaceAll(RegExp(r'<br\s*/?>\s*'), '\n');

    parsedString = parsedString.replaceAll('\t', '');
    parsedString = parsedString.replaceAll(RegExp(r'\n{3,}'), '\n\n');
    parsedString = parsedString.replaceAll(RegExp('\n\n'), '\n');
    return parsedString.trim();
  }

  static String convertListMapToString(List<Map<String, dynamic>> list) {
    return list.map((e) => e.toString()).join('||');
  }

  static List<String> convertStringToListMap(String input) {
    if (input.isEmpty) return [];
    return input.split('||');
  }

  const StringUtilities._();
}
