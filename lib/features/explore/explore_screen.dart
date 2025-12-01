import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/dependency/network_api/story/filter/story_filter_request.dart';
import 'package:flutter_template/features/explore/enum/explore_enum.dart';
import 'package:flutter_template/features/explore/widgets/category_page_widget.dart';
import 'package:flutter_template/features/explore/widgets/explore_page_widget.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/page_view/app_page_view.dart';
import 'package:flutter_template/shared/widgets/story_list/enum/story_list_type.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

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
    final bloc = ref.watch(BlocProvider.explore);
    final t = context.t;
    final initialRequest = bloc.args?.request;
    final title = bloc.args?.title ?? t.exploreScreen.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
          PopupMenuButton<StoryListType>(
            icon: const Icon(Icons.more_vert),
            onSelected: bloc.onChangeListType,
            itemBuilder: (context) {
              final current = bloc.listTypeSubject.value;

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
        streams: [bloc.listTypeSubject],
        builder: (context) {
          if (initialRequest != null) {
            return ExplorePageWidget(
              request: initialRequest,
              listType: bloc.listTypeSubject.value,
            );
          }
          return AppPageView(
            isScrollTabView: true,
            isScrollable: true,
            onPageChanged: (index) {},
            items: ExploreEnum.values.map(
              (e) {
                if (e == ExploreEnum.genres) {
                  return AppPageViewItems(
                    key: ValueKey('categoryPage_${e.label(context)}'),
                    label: e.label(context),
                    child: const CategoryPageWidget(),
                    labelStyle: TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  );
                }
                return AppPageViewItems(
                  label: e.label(context),
                  child: ExplorePageWidget(
                    key: ValueKey('explorePage_${e.label(context)}'),
                    request: StoryFilterRequest(
                      sort: e.page,
                    ),
                    listType: bloc.listTypeSubject.value,
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
