import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/features/story/read_story/extension/read_story_tts_extension.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';

class ReadStoryTtsSettings extends ConsumerWidget {
  const ReadStoryTtsSettings({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.readStory);
    final theme = Theme.of(context);
    final t = context.t;

    final isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return ObsBuilder(
      streams: [
        bloc.configStorySubject,
        bloc.ttsConfigSubject,
      ],
      builder: (context) {
        final config = bloc.configStorySubject.value;
        final backgroundColor = config.themeMode.backgroundControllerColor;
        final textColor = config.themeMode.textColor;

        final ttsConfig = bloc.ttsConfigSubject.value;

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
                  child: Text(
                    t.readStory.ttsSettings.title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                Row(
                  children: [
                    SizedBoxConstants.s16,
                    Expanded(
                      flex: 3,
                      child: Text(
                        t.readStory.ttsSettings.rate,
                        style: TextStyle(color: textColor),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Row(
                        children: [
                          Text(
                            ttsConfig.rate.toStringAsFixed(1),
                            style: TextStyle(color: textColor, fontSize: 12),
                          ),
                          Expanded(
                            child: Slider(
                              value: ttsConfig.rate,
                              min: 0.0,
                              max: 1.0,
                              divisions: 10,
                              label: ttsConfig.rate.toStringAsFixed(1),
                              activeColor: theme.colorScheme.primary,
                              inactiveColor:
                                  theme.colorScheme.primary.withValues(
                                alpha: 0.3,
                              ),
                              onChanged: (value) {
                                bloc.onChangeTtsRate(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBoxConstants.s16,
                  ],
                ),
                Row(
                  children: [
                    SizedBoxConstants.s16,
                    Expanded(
                      flex: 3,
                      child: Text(
                        t.readStory.ttsSettings.pitch,
                        style: TextStyle(color: textColor),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Row(
                        children: [
                          Text(
                            ttsConfig.pitch.toStringAsFixed(1),
                            style: TextStyle(color: textColor, fontSize: 12),
                          ),
                          Expanded(
                            child: Slider(
                              value: ttsConfig.pitch,
                              min: 0.5,
                              max: 2.0,
                              divisions: 15,
                              label: ttsConfig.pitch.toStringAsFixed(1),
                              activeColor: theme.colorScheme.primary,
                              inactiveColor:
                                  theme.colorScheme.primary.withValues(
                                alpha: 0.3,
                              ),
                              onChanged: (value) {
                                bloc.onChangeTtsPitch(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBoxConstants.s16,
                  ],
                ),
                if (!isIos)
                  Row(
                    children: [
                      SizedBoxConstants.s16,
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Bộ đọc',
                          style: TextStyle(color: textColor),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: DropdownButton<String>(
                          value: ttsConfig.selectedEngine,
                          dropdownColor: backgroundColor,
                          isExpanded: true,
                          underline: Container(
                            height: 1,
                            color: textColor.withValues(alpha: 0.3),
                          ),
                          icon: Icon(
                            Icons.settings_system_daydream,
                            color: textColor,
                          ),
                          style: TextStyle(color: textColor),
                          items: ttsConfig.availableEngines.map((engine) {
                            return DropdownMenuItem<String>(
                              value: engine,
                              child: Text(
                                _formatEngineName(engine),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            );
                          }).toList(),
                          onChanged: (newEngine) {
                            if (newEngine != null) {
                              bloc.onChangeEngine(
                                newEngine,
                              );
                            }
                          },
                        ),
                      ),
                      SizedBoxConstants.s16,
                    ],
                  ),

                if (!isIos)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        SizedBoxConstants.s16,
                        Expanded(
                          flex: 3,
                          child: Text(
                            t.readStory.ttsSettings.language,
                            style: TextStyle(color: textColor),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: DropdownButton<String>(
                            value: ttsConfig.selectedLanguage,
                            dropdownColor: backgroundColor,
                            isExpanded: true,
                            underline: Container(
                              height: 1,
                              color: textColor.withValues(alpha: 0.3),
                            ),
                            icon: Icon(Icons.arrow_drop_down, color: textColor),
                            style: TextStyle(color: textColor),
                            items: ttsConfig.uniqueLanguages.map((lang) {
                              return DropdownMenuItem<String>(
                                value: lang,
                                child: Text(lang),
                              );
                            }).toList(),
                            onChanged: bloc.onChangeLanguage,
                          ),
                        ),
                        SizedBoxConstants.s16,
                      ],
                    ),
                  ),

                if (!isIos)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        SizedBoxConstants.s16,
                        Expanded(
                          flex: 3,
                          child: Text(
                            t.readStory.ttsSettings.voice,
                            style: TextStyle(color: textColor),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: DropdownButton<String>(
                            value: ttsConfig.selectedVoice?['name'],
                            dropdownColor: backgroundColor,
                            isExpanded: true,
                            underline: Container(
                              height: 1,
                              color: textColor.withValues(alpha: 0.3),
                            ),
                            icon: Icon(Icons.arrow_drop_down, color: textColor),
                            style: TextStyle(color: textColor),
                            items: ttsConfig.voicesForSelectedLanguage
                                .map((voice) {
                              return DropdownMenuItem<String>(
                                value: voice['name'],
                                child: Text(
                                  voice['display'] ??
                                      '', // Hiển thị tên kèm (Online)
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (voiceName) {
                              if (voiceName != null) {
                                final selected =
                                    ttsConfig.availableVoices.firstWhere(
                                  (element) => element['name'] == voiceName,
                                );
                                bloc.onChangeTtsVoice(selected);
                              }
                            },
                          ),
                        ),
                        SizedBoxConstants.s16,
                      ],
                    ),
                  ),
                SizedBoxConstants.s16,
                Padding(
                  padding: EdgeInsetsConstants.horizontal16,
                  child: Row(
                    children: [
                      if (!isIos)
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: AppGestureDetector(
                              onTap: () => bloc.onTapTryTtsVoice(),
                              child: Text(
                                t.readStory.ttsSettings.tryVoice,
                                style: TextStyle(
                                  color: theme.colorScheme.primary,
                                  decoration: TextDecoration.underline,
                                  decorationColor: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: AppGestureDetector(
                            onTap: () => bloc.onTapResetTtsSettings(),
                            child: Text(
                              t.readStory.resetToDefault,
                              style: TextStyle(
                                color: theme.colorScheme.error,
                                decoration: TextDecoration.underline,
                                decorationColor: theme.colorScheme.error,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBoxConstants.s16,
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatEngineName(String packageName) {
    if (packageName.contains('google')) return 'Google Speech Services';
    if (packageName.contains('samsung')) return 'Samsung TTS';
    if (packageName.contains('xiaomi') || packageName.contains('mibrain')) {
      return 'Mi AI Speech';
    }
    return packageName;
  }
}
