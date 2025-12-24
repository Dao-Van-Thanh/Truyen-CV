import 'dart:async';
import 'package:flutter/foundation.dart';

class ActionConfirmHelper {
  final Duration timeout;
  Timer? _timer;

  ActionConfirmHelper({
    this.timeout = const Duration(seconds: 3),
  });

  void execute({
    required VoidCallback onFirstTap,
    required VoidCallback onConfirmed,
  }) {
    if (_timer != null && _timer!.isActive) {
      _cancelTimer();
      onConfirmed();
      return;
    }

    onFirstTap();

    _timer = Timer(timeout, () {
      _cancelTimer();
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    _cancelTimer();
  }
}
