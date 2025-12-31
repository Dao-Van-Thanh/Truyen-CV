import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/font_family_enum.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/bloc/config/app_config_bloc.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appConfigBloc = ref.watch(BlocProvider.config);
    final t = context.t;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.setting.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SECTION 1 ---
            _buildSectionHeader(context, t.setting.systemAndUI),

            ObsBuilder(
              streams: [appConfigBloc.themeModeSubject],
              builder: (context) {
                return _buildSettingItem(
                  context,
                  icon: Icons.brightness_6_outlined,
                  title: t.setting.appTheme,
                  subtitle: _getThemeName(
                    context,
                    appConfigBloc.themeModeSubject.value,
                  ),
                  onTap: () => _showThemePicker(context, appConfigBloc),
                );
              },
            ),

            ObsBuilder(
              streams: [appConfigBloc.localeSubject],
              builder: (context) {
                final locale = appConfigBloc.localeSubject.value;
                return _buildSettingItem(
                  context,
                  icon: Icons.language,
                  title: t.setting.language,
                  subtitle: locale.languageCode == 'vi'
                      ? t.setting.vietnamese
                      : t.setting.english,
                  onTap: () => _showLanguagePicker(context, appConfigBloc),
                );
              },
            ),

            const Divider(height: 32),

            // --- SECTION 2 ---
            _buildSectionHeader(context, t.setting.readerSettings),

            ObsBuilder(
              streams: [appConfigBloc.fontSizeSubject],
              builder: (context) {
                final fontSize = appConfigBloc.fontSizeSubject.value;
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.format_size),
                      title: Text(t.setting.fontSize),
                      trailing: Text(fontSize.toInt().toString()),
                    ),
                    Slider(
                      value: fontSize,
                      min: 12,
                      max: 40,
                      divisions: 28,
                      label: fontSize.round().toString(),
                      onChanged: appConfigBloc.onChangeFontSize,
                    ),
                  ],
                );
              },
            ),

            ObsBuilder(
              streams: [appConfigBloc.lineHeightSubject],
              builder: (context) {
                final height = appConfigBloc.lineHeightSubject.value;
                return Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.format_line_spacing),
                      title: Text(t.setting.lineHeight),
                      trailing: Text(height.toStringAsFixed(1)),
                    ),
                    Slider(
                      value: height,
                      min: 1.0,
                      max: 3.0,
                      divisions: 20,
                      label: height.toStringAsFixed(1),
                      onChanged: appConfigBloc.onChangeLineHeight,
                    ),
                  ],
                );
              },
            ),

            ObsBuilder(
              streams: [appConfigBloc.fontFamilySubject],
              builder: (context) {
                final font = appConfigBloc.fontFamilySubject.value;
                return _buildSettingItem(
                  context,
                  icon: Icons.font_download_outlined,
                  title: t.setting.fontFamily,
                  subtitle: font.displayName,
                  onTap: () => _showFontPicker(context, appConfigBloc),
                );
              },
            ),

            const Divider(height: 32),

            // --- SECTION 3 ---
            _buildSectionHeader(context, t.setting.dataAndStorage),

            _buildSettingItem(
              context,
              icon: Icons.delete_forever_outlined,
              title: t.setting.deleteData,
              subtitle: t.setting.deleteDataDesc,
              iconColor: Colors.red,
              textColor: Colors.red,
              onTap: () => _showDeleteConfirmDialog(context, appConfigBloc),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _buildSettingItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
      onTap: onTap,
    );
  }

  String _getThemeName(BuildContext context, ThemeMode mode) {
    final t = context.t;
    switch (mode) {
      case ThemeMode.system:
        return t.setting.themeSystem;
      case ThemeMode.light:
        return t.setting.themeLight;
      case ThemeMode.dark:
        return t.setting.themeDark;
    }
  }

  void _showThemePicker(BuildContext context, AppConfigBloc bloc) {
    final t = context.t;
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(t.setting.themeSystem),
            onTap: () {
              bloc.onChangeThemeMode(ThemeMode.system);
              Navigator.pop(ctx);
            },
          ),
          ListTile(
            title: Text(t.setting.themeLight),
            onTap: () {
              bloc.onChangeThemeMode(ThemeMode.light);
              Navigator.pop(ctx);
            },
          ),
          ListTile(
            title: Text(t.setting.themeDark),
            onTap: () {
              bloc.onChangeThemeMode(ThemeMode.dark);
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, AppConfigBloc bloc) {
    final t = context.t;
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(t.setting.vietnamese),
            onTap: () {
              bloc.onChangeLocale(AppLocale.vi);
              Navigator.pop(ctx);
            },
          ),
          ListTile(
            title: Text(t.setting.english),
            onTap: () {
              bloc.onChangeLocale(AppLocale.en);
              Navigator.pop(ctx);
            },
          ),
        ],
      ),
    );
  }

  void _showFontPicker(BuildContext context, AppConfigBloc bloc) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => ListView.builder(
        shrinkWrap: true,
        itemCount: FontFamilyEnum.values.length,
        itemBuilder: (ctx, index) {
          final fontName = FontFamilyEnum.values[index];
          final isSelected = fontName == bloc.fontFamilySubject.value;
          return ListTile(
            title: Text(
              fontName.displayName,
              style: TextStyle(fontFamily: fontName.familyName),
            ),
            trailing: isSelected
                ? const Icon(Icons.check, color: Colors.green)
                : null,
            onTap: () {
              bloc.onChangeFontFamily(fontName);
              Navigator.pop(ctx);
            },
          );
        },
      ),
    );
  }

  void _showDeleteConfirmDialog(
    BuildContext context,
    AppConfigBloc appConfigBloc,
  ) {
    final t = context.t;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.setting.confirmDelete),
        content: Text(t.setting.deleteWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t.setting.cancel),
          ),
          TextButton(
            onPressed: () {
              appConfigBloc.clearAllData();
              Navigator.pop(ctx);
            },
            child: Text(
              t.setting.delete,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
