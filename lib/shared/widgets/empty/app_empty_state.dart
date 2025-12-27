import 'package:flutter/material.dart';
import 'package:flutter_template/constants/size_box.dart';

class AppEmptyState extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? customImage;
  final String? buttonText;
  final VoidCallback? onPressed;
  final bool showBackgroundCircle;

  const AppEmptyState({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.customImage,
    this.buttonText,
    this.onPressed,
    this.showBackgroundCircle = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final visualWidget = customImage ??
        Icon(
          icon ?? Icons.inbox_outlined,
          size: 64,
          color: colorScheme.primary,
        );

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showBackgroundCircle && customImage == null)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: visualWidget,
              )
            else
              visualWidget,

            SizedBoxConstants.s24,

            // 2. Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),

            if (subtitle != null) ...[
              SizedBoxConstants.s8,
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
            ],

            if (buttonText != null && onPressed != null) ...[
              SizedBoxConstants.s24,
              FilledButton.tonal(
                onPressed: onPressed,
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
