import 'dart:async';
import 'package:flutter/foundation.dart';

class TtsTimerHelper {
  Timer? _timer;

  final StreamController<int> _remainingController =
      StreamController<int>.broadcast();
  Stream<int> get remainingTimeStream => _remainingController.stream;

  VoidCallback? onTimerFinished;

  bool get isRunning => _timer != null && _timer!.isActive;

  void startTimer(int minutes) {
    stopTimer();

    int remainingSeconds = minutes * 60;
    _remainingController.add(remainingSeconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingSeconds--;
      _remainingController.add(remainingSeconds);

      if (remainingSeconds <= 0) {
        stopTimer();
        onTimerFinished?.call();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    if (_remainingController.isClosed) return;
    _remainingController.add(-1);
  }

  String formatTime(int totalSeconds) {
    if (totalSeconds < 0) return '';
    final duration = Duration(seconds: totalSeconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    if (duration.inHours > 0) {
      return '${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}';
    }
    return '${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}';
  }

  void dispose() {
    stopTimer();
    if (_remainingController.isClosed) return;
    _remainingController.close();
  }
}
