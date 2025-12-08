import 'dart:convert';

class StringUtilities {
  static String clearHtml(String input) {
    String parsedString = input.replaceAll(RegExp(r'<br\s*/?>\s*'), '\n');

    parsedString = parsedString.replaceAll('\t', '');
    parsedString = parsedString.replaceAll(RegExp(r'\n{3,}'), '\n\n');
    parsedString = parsedString.replaceAll(RegExp('\n\n'), '\n');
    return parsedString.trim();
  }

  static String convertListMapToString(List<Map<String, dynamic>> list) {
    return jsonEncode(list);
  }

  static List<Map<String, dynamic>> convertStringToListMap(String input) {
    if (input.isEmpty) return [];
    try {
      final List<dynamic> jsonList = jsonDecode(input);

      return jsonList.map((e) => Map<String, dynamic>.from(e)).toList();
    } catch (e) {
      return [];
    }
  }

  const StringUtilities._();
}
