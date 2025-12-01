import 'package:flutter/cupertino.dart';
import 'package:flutter_template/shared/utilities/debounce.dart';

extension TextEditingControllerExtension on TextEditingController {
  VoidCallback addListenerText(
    Function(String text) onChanged, {
    Debounce? debounce,
  }) {
    String previousText = text;
    void listener() {
      if (text == previousText) return;

      previousText = text;

      if (debounce != null) {
        debounce.run(() {
          previousText = text;
          onChanged(text);
        });
      } else {
        onChanged(text);
      }
    }

    addListener(listener);
    return listener;
  }
}
