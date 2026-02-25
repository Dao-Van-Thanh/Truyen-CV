import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_base.dart';
import 'package:flutter_template/dependency/app_service.dart';
import 'package:flutter_template/dependency/router/arguments/explore_argument.dart';
import 'package:flutter_template/dependency/router/utils/route_input.dart';
import 'package:flutter_template/features/explore/enum/explore_navigation_enum.dart';
import 'package:rxdart/rxdart.dart';

class ExploreBloc extends BlocBase {
  Ref ref;
  ExploreArgument? args;

  late final routerService = ref.read(AppService.router);

  final exploreNavigationEnumSubject =
      BehaviorSubject<ExploreNavigationEnum>.seeded(
    ExploreNavigationEnum.novel,
  );

  ExploreBloc(this.ref, {this.args});

  @override
  void dispose() {
    super.dispose();
    exploreNavigationEnumSubject.close();
  }

  void onTapSearch() {
    routerService.push(
      RouteInput.storySearch(),
    );
  }

  void onTapExploreType() {
    final current = exploreNavigationEnumSubject.value;

    showModalBottomSheet<ExploreNavigationEnum>(
      context: routerService.rootContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: ExploreNavigationEnum.values.map((type) {
              final isSelected = type == current;

              return ListTile(
                leading: IconTheme(
                  data: IconThemeData(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                  ),
                  child: type.icon,
                ),
                title: Text(
                  type.displayName,
                  style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : null,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () {
                  Navigator.pop(context, type);
                },
              );
            }).toList(),
          ),
        );
      },
    ).then((value) {
      if (value != null && value != current) {
        _onChangeExploreType(value);
      }
    });
  }

  void _onChangeExploreType(ExploreNavigationEnum value) {
    exploreNavigationEnumSubject.value = value;
  }
}
