class MapUtil {
  static Map<String, dynamic> castMap(Map map) {
    final result = <String, dynamic>{};
    map.forEach((key, value) {
      if (value is Map) {
        result[key] = castMap(value.cast<String, dynamic>());
      } else if (value is List) {
        result[key] = value
            .map((e) => e is Map ? castMap(e.cast<String, dynamic>()) : e)
            .toList();
      } else {
        result[key] = value;
      }
    });
    return result;
  }

  static Map<String, dynamic> removeNullRecursive(Map<String, dynamic> json) {
    final result = <String, dynamic>{};
    json.forEach((key, value) {
      if (value == null) {
        // bỏ qua key null
        return;
      }
      if (value is Map<String, dynamic>) {
        // đệ quy vào map
        final cleanedMap = removeNullRecursive(value);
        if (cleanedMap.isNotEmpty) {
          result[key] = cleanedMap;
        }
      } else if (value is List) {
        // xử lý list
        final cleanedList = value.map((item) {
          if (item is Map<String, dynamic>) {
            return removeNullRecursive(item);
          }
          return item;
        }).where((item) {
          // giữ lại item khác null hoặc map không empty
          if (item == null) return false;
          if (item is Map && item.isEmpty) return false;
          return true;
        }).toList();

        if (cleanedList.isNotEmpty) {
          result[key] = cleanedList;
        }
      } else {
        // giữ lại value bình thường
        result[key] = value;
      }
    });
    return result;
  }

  const MapUtil._();
}
