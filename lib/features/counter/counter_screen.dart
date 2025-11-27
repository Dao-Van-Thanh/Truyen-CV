import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/i18n/strings.g.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.counter);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        actions: [
          //change language button
          PopupMenuButton<AppLocale>(
            icon: const Icon(Icons.language),
            onSelected: (locale) {
              LocaleSettings.setLocale(locale).then(
                (value) {},
              );
            },
            itemBuilder: (context) => AppLocale.values
                .map((locale) => PopupMenuItem<AppLocale>(
                      value: locale,
                      child: Text(locale.languageCode.toUpperCase()),
                    ))
                .toList(),
          ),
        ],
        // leading button change theme
        leading: IconButton(
          icon: const Icon(Icons.brightness_6),
          onPressed: () {
            ref.read(BlocProvider.config).onToggleThemeMode();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ObsBuilder(
              streams: [bloc.counterSubject],
              builder: (ctx) => Text(
                '${context.t.buttonPressCount}: ${bloc.counterSubject.value}',
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bloc.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
