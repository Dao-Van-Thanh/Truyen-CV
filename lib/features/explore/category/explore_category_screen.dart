import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/features/explore/widgets/explore_page_widget.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';

class ExploreCategoryScreen extends ConsumerWidget {
  const ExploreCategoryScreen({super.key});

  String _labelOfType(StoryListType type, BuildContext context) {
    final t = context.t;
    switch (type) {
      case StoryListType.grid:
        return t.exploreScreen.listType.grid;
      case StoryListType.list:
        return t.exploreScreen.listType.list;
      case StoryListType.listCompact:
        return t.exploreScreen.listType.listCompact;
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.exploreCategory);
    final initialRequest = bloc.args.request;
    final title = bloc.args.title ?? context.t.exploreScreen.title;
    final appConfigBloc = ref.read(BlocProvider.config);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: bloc.onTapSearch,
          ),
          PopupMenuButton<StoryListType>(
            icon: const Icon(Icons.more_vert),
            onSelected: appConfigBloc.onChangeTypeListDisplay,
            itemBuilder: (context) {
              final current = appConfigBloc.typeListDisplaySubject.value;

              return StoryListType.values.map((type) {
                final isSelected = type == current;

                return PopupMenuItem(
                  value: type,
                  child: Row(
                    children: [
                      IconTheme(
                        data: IconThemeData(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : null,
                        ),
                        child: type.icon,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _labelOfType(type, context),
                          style: TextStyle(
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : null,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ObsBuilder(
        streams: [appConfigBloc.typeListDisplaySubject],
        builder: (context) {
          return ExplorePageWidget(
            request: initialRequest,
            listType: appConfigBloc.typeListDisplaySubject.value,
          );
        },
      ),
    );
  }
}
