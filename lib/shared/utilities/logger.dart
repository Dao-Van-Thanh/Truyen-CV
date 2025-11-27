import 'package:logger/logger.dart';

final AppLogger _appLogger = AppLogger();

AppLogger get logger => _appLogger;

class AppLogger {
  final _logger = Logger();

  void d(dynamic message) {
    _logger.d(message);
  }

  void e(dynamic message) {
    _logger.e(message);
  }

  void i(dynamic message) {
    _logger.i(message);
  }

  void w(dynamic message) {
    _logger.w(message);
  }

  void t(dynamic message) {
    _logger.t(message);
  }

  void f(dynamic message) {
    _logger.f(message);
  }
}
