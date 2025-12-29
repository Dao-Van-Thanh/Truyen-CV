import 'package:flutter_template/shared/utilities/logger.dart';

class AsyncUtil {
  static Future<T> measureAwait<T>(
    String label,
    Future<T> Function() action,
  ) async {
    final stopwatch = Stopwatch()..start();

    try {
      return await action();
    } finally {
      stopwatch.stop();
      logger.d(
        '[PERF] $label took ${stopwatch.elapsedMilliseconds} ms',
      );
    }
  }

  AsyncUtil._();
}
