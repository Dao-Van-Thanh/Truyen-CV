import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/logger.dart';

class FileImportDialog extends ConsumerStatefulWidget {
  final String filePath;

  const FileImportDialog({super.key, required this.filePath});

  @override
  ConsumerState<FileImportDialog> createState() => _FileImportDialogState();
}

class _FileImportDialogState extends ConsumerState<FileImportDialog>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _processFile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      String finalPath = widget.filePath;

      if (finalPath.startsWith('/document/raw:')) {
        finalPath = finalPath.replaceFirst('/document/raw:', '');
      } else if (finalPath.startsWith('file://')) {
        finalPath = finalPath.replaceFirst('file://', '');
      }

      try {
        if (finalPath.contains('%')) {
          finalPath = Uri.decodeFull(finalPath);
        }
      } catch (e) {
        logger.w('Path chứa ký tự đặc biệt, không decode URI: $e');
      }

      await Future.delayed(const Duration(milliseconds: 50));

      final res = await ref.read(AppService.importFile).importFile(finalPath);

      logger.i('Kết quả import: $res');

      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      logger.e('Lỗi khi xử lý path: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = context.t;

    return Material(
      color: Colors.transparent,
      child: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 320),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Card(
              elevation: 8,
              shadowColor: colorScheme.shadow.withValues(alpha: 0.3),
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_isLoading) ...[
                      const CircularProgressIndicator(),
                      const SizedBox(height: 16),
                      Text(
                        t.fileImport.importing,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ] else ...[
                      Icon(
                        Icons.library_books,
                        size: 48,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        t.fileImport.addToLibrary,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.filePath.split('/').last,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (!_isLoading) ...[
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(t.fileImport.cancel),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton(
                              onPressed: _processFile,
                              child: Text(t.fileImport.add),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
