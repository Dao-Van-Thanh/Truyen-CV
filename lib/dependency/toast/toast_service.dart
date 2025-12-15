import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToastService {
  final Ref ref;
  final observer = BotToastNavigatorObserver();

  ToastService(this.ref);

  TransitionBuilder init() {
    return BotToastInit();
  }

  void showToastNotification({required ToastBuilder builder}) {
    BotToast.showCustomNotification(
      useSafeArea: true,
      toastBuilder: builder,
    );
  }

  void showText({String? message, Duration? duration}) {
    BotToast.showText(
      text: message ?? 'Error',
      duration: duration ?? const Duration(seconds: 4),
    );
  }
}
