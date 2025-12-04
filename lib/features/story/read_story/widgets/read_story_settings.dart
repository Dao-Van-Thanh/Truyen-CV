import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/constants/font_family_enum.dart';
import 'package:flutter_template/features/story/read_story/enum/read_theme_mode.dart';

class ReadStorySettings extends ConsumerWidget {
  const ReadStorySettings({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.readStory);
    final theme = Theme.of(context);
    return ObsBuilder(
      streams: [
        bloc.configStorySubject,
      ],
      builder: (context) {
        final config = bloc.configStorySubject.value;
        final backgroundColor = config.themeMode.backgroundControllerColor;
        final textColor = config.themeMode.textColor;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16),
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBoxConstants.s16,
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SizedBoxConstants.s16,
                      ...ReadThemeMode.values.map((mode) {
                        final isSelected = mode == config.themeMode;
                        return GestureDetector(
                          onTap: () {
                            bloc.onSelectedThemeMode(mode);
                          },
                          child: Container(
                            margin: EdgeInsetsConstants.right12,
                            padding: EdgeInsetsConstants.all12,
                            decoration: BoxDecoration(
                              color: mode.backgroundColor,
                              border: Border.all(
                                color: isSelected
                                    ? theme.colorScheme.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              'Aa',
                              style: TextStyle(
                                color: mode.textColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
                SizedBoxConstants.s16,
                Row(
                  children: [
                    SizedBoxConstants.s16,
                    Expanded(
                      child: Text(
                        'Font Size',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: config.fontSize,
                        min: 12,
                        max: 30,
                        divisions: 18,
                        label: config.fontSize.toStringAsFixed(0),
                        activeColor: theme.colorScheme.primary,
                        inactiveColor: theme.colorScheme.primary.withValues(
                          alpha: 0.3,
                        ),
                        onChanged: (value) {
                          bloc.onChangeFontSize(value);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBoxConstants.s16,
                    Expanded(
                      child: Text(
                        'Line Height',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: config.lineHeight,
                        min: 1.0,
                        max: 2.0,
                        divisions: 10,
                        label: config.lineHeight.toStringAsFixed(1),
                        activeColor: theme.colorScheme.primary,
                        inactiveColor: theme.colorScheme.primary.withValues(
                          alpha: 0.3,
                        ),
                        onChanged: (value) {
                          bloc.onChangeLineHeight(value);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBoxConstants.s16,
                    Expanded(
                      child: Text(
                        'Font Family',
                        style: TextStyle(
                          color: textColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: config.fontFamily,
                        dropdownColor: backgroundColor,
                        style: TextStyle(
                          color: textColor,
                        ),
                        alignment: Alignment.centerRight,
                        isExpanded: true,
                        items: FontFamilyEnum.values.map((font) {
                          return DropdownMenuItem<String>(
                            value: font.familyName,
                            child: Text(font.name.toUpperCase()),
                          );
                        }).toList(),
                        onChanged: bloc.onChangeFontFamily,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
