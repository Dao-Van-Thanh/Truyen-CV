import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/shared/widgets/bottom_navigation_bar/enum/bottom_navigation_bar_enum.dart';

class AppBottomNavigationBar extends ConsumerWidget {
  const AppBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.root);
    return ObsBuilder(
      streams: [bloc.selectedNavigationBarSubject],
      builder: (context) {
        return BottomNavigationBar(
          currentIndex: BottomNavigationBarEnum.values
              .indexOf(bloc.selectedNavigationBarSubject.value),
          onTap: (index) {
            final selectedItem = BottomNavigationBarEnum.values[index];
            bloc.selectNavigationBar(selectedItem);
          },
          items: BottomNavigationBarEnum.values.map((e) {
            return BottomNavigationBarItem(
              icon: e.icon,
              label: e.label(context),
            );
          }).toList(),
        );
      },
    );
  }
}
