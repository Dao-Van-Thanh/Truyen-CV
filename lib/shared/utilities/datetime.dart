import 'package:flutter_template/i18n/strings.g.dart';
import 'package:intl/intl.dart';

class DatetimeUtil {
  static DateTime? parseIsoToDateTime(String? isoString) {
    if (isoString == null || isoString.isEmpty) return null;
    try {
      final dateTime = DateTime.parse(isoString);
      return dateTime.toLocal();
    } catch (e) {
      return null;
    }
  }

  static String formatDateTime(
    DateTime? dateTime, {
    String format = 'dd/MM/yyyy',
  }) {
    try {
      if (dateTime == null) return '';
      final formatter = DateFormat(
        format,
      );
      return formatter.format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static String formatDateTimeParseString(
    String? dateString, {
    String format = 'MM/yyyy',
  }) {
    if (dateString == null) return '';
    try {
      final formatter = DateFormat(format);
      final date = formatter.parse(dateString);
      return formatter.format(date);
    } catch (e) {
      return '';
    }
  }

  static String formatDateTimeParseISOString(
    String? dateString, {
    String format = 'dd/MM/yyyy',
  }) {
    if (dateString == null) return '';
    try {
      final date = DateTime.parse(dateString).toLocal();
      final formatter = DateFormat(format);
      return formatter.format(date);
    } catch (e) {
      return '';
    }
  }

  static DateTime? parseDateString(
    String? dateString, {
    String format = 'dd/MM/yyyy',
    String? locale = 'vi_VN',
  }) {
    try {
      if (dateString == null) return null;
      final formatter = DateFormat(format, locale);
      return formatter.parse(dateString);
    } catch (e) {
      return null;
    }
  }

  static bool isValidDateFormat(String? input, String format) {
    if (input == null) return false;
    try {
      final dateFormat = DateFormat(format);
      dateFormat.parseStrict(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  static DateTime? parseFlexibleDateString(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;

    final possibleFormats = [
      'HH:mm:ss dd/MM/yyyy',
      'HH:mm dd/MM/yyyy',
      'dd/MM/yyyy HH:mm:ss',
      'dd/MM/yyyy HH:mm',
      'dd/MM/yyyy',
    ];

    for (final format in possibleFormats) {
      try {
        return DateFormat(format, 'vi_VN').parseStrict(dateString);
      } catch (_) {}
    }
    return null;
  }

  static String getTimeTransactionFlexible(
    String? rawDateTime, {
    required String format,
  }) {
    final date = parseFlexibleDateString(rawDateTime);
    return formatDateTime(date, format: format);
  }

  static String formatRelativeDate(DateTime? date, Translations t) {
    if (date == null) return '';

    final localDate = date.toLocal();
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(localDate.year, localDate.month, localDate.day);

    final difference = today.difference(targetDate).inDays;

    if (difference == 0) {
      return t.common.today; 
    } else if (difference == 1) {
      return t.common.yesterday; 
    } else {
      return formatDateTime(localDate, format: 'dd/MM/yyyy');
    }
  }

  const DatetimeUtil._();
}
