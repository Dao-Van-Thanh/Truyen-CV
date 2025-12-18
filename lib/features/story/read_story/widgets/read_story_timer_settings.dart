import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/features/story/read_story/extension/read_story_tts_extension.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';

class ReadStoryTimerSettings extends ConsumerWidget {
  const ReadStoryTimerSettings({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.readStory);
    final theme = Theme.of(context);

    final presets = [15, 30, 45, 60, 90];

    return ObsBuilder(
      streams: [
        bloc.configStorySubject,
        bloc.isTimerRunningSubject,
        bloc.timerStringSubject,
      ],
      builder: (context) {
        final config = bloc.configStorySubject.value;
        final isRunning = bloc.isTimerRunningSubject.value;
        final timerText = bloc.timerStringSubject.value;

        final backgroundColor = config.themeMode.backgroundControllerColor;
        final textColor = config.themeMode.textColor;
        final primaryColor = theme.colorScheme.primary;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: EdgeInsetsConstants.all16,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hẹn giờ tắt',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (isRunning)
                        AppGestureDetector(
                          onTap: () => bloc.cancelSleepTimer(),
                          child: Text(
                            'Hủy hẹn giờ',
                            style: TextStyle(
                              color: theme.colorScheme.error,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                if (isRunning) ...[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        timerText, // 14:59
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 48,
                          fontWeight: FontWeight.w600,
                          fontFeatures: const [
                            FontFeature.tabularFigures(),
                          ], // Để số không bị nhảy
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Ứng dụng sẽ tự động dừng đọc khi hết giờ',
                      style: TextStyle(color: textColor.withValues(alpha: 0.7)),
                    ),
                  ),
                  SizedBoxConstants.s24,
                ] else ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.start,
                      children: [
                        // Các nút Preset
                        ...presets.map(
                          (minutes) => _buildOptionChip(
                            context,
                            label: '$minutes phút',
                            textColor: textColor,
                            borderColor: textColor.withValues(alpha: 0.3),
                            onTap: () => bloc.setSleepTimer(
                              minutes,
                            ),
                          ),
                        ),

                        _buildOptionChip(
                          context,
                          label: 'Tùy chỉnh...',
                          icon: Icons.edit_outlined,
                          textColor: textColor,
                          borderColor: textColor.withValues(alpha: 0.3),
                          onTap: () => _showCustomInputDialog(context, (val) {
                            bloc.setSleepTimer(val);
                          }),
                        ),
                      ],
                    ),
                  ),
                  SizedBoxConstants.s32,
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildOptionChip(
    BuildContext context, {
    required String label,
    required Color textColor,
    required Color borderColor,
    required VoidCallback onTap,
    IconData? icon,
  }) {
    return AppGestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: textColor, size: 16),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomInputDialog(BuildContext context, Function(int) onConfirm) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nhập số phút'),
          content: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Ví dụ: 120',
              suffixText: 'phút',
            ),
            onSubmitted: (_) {
              final val = int.tryParse(controller.text);
              if (val != null && val > 0) {
                onConfirm(val);
                Navigator.pop(context);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            TextButton(
              onPressed: () {
                final val = int.tryParse(controller.text);
                if (val != null && val > 0) {
                  onConfirm(val);
                  Navigator.pop(context);
                }
              },
              child: const Text('Đồng ý'),
            ),
          ],
        );
      },
    );
  }
}
