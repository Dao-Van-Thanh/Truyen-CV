import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  const HighlightText(
    this.fullText, {
    super.key,
    required this.highlightTexts,
    this.style,
    this.highlightStyle,
    this.maxLines,
    this.textAlign = TextAlign.center,
    this.overflow = TextOverflow.clip,
    this.onTapHighlight,
  });

  final String fullText;
  final List<String> highlightTexts; // from top to bottom, from left to right
  final TextStyle? style;
  final TextStyle? highlightStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow overflow;
  final void Function(String textHighlight)? onTapHighlight;

  @override
  Widget build(BuildContext context) {
    final List<InlineSpan> inlineSpans = [];
    int currentIndex = 0;

    for (final text in highlightTexts) {
      final indexOfText = fullText.indexOf(text, currentIndex);

      if (indexOfText != -1) {
        // Text trước đoạn highlight
        inlineSpans.add(
          TextSpan(
            text: fullText.substring(currentIndex, indexOfText),
            style: style,
          ),
        );

        // Text highlight có thể click
        inlineSpans.add(
          TextSpan(
            text: text,
            style: highlightStyle,
            recognizer: onTapHighlight != null
                ? (TapGestureRecognizer()
                  ..onTap = () {
                    onTapHighlight?.call(text);
                  })
                : null,
          ),
        );

        currentIndex = indexOfText + text.length;
      }
    }

    // Phần text còn lại
    inlineSpans.add(
      TextSpan(
        text: fullText.substring(currentIndex),
        style: style,
      ),
    );

    return RichText(
      textAlign: textAlign,
      text: TextSpan(children: inlineSpans),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
