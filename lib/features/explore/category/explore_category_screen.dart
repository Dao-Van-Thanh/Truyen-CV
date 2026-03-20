import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/bloc/rx/obs_builder.dart';
import 'package:truyen_cv/dependency/router/arguments/explore_category_argument.dart';
import 'package:truyen_cv/features/explore/category/explore_category_bloc.dart';
import 'package:truyen_cv/features/explore/comic/widget/explore_comic_page_widget.dart';
import 'package:truyen_cv/features/explore/novel/widget/explore_novel_page_widget.dart';
import 'package:truyen_cv/i18n/strings.g.dart';
import 'package:truyen_cv/shared/widgets/story_list/enum/story_list_type.dart';

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
        streams: [
          appConfigBloc.typeListDisplaySubject,
        ],
        builder: (context) {
          return _buildBody(bloc, appConfigBloc.typeListDisplaySubject.value);
        },
      ),
    );
  }

  Widget _buildBody(ExploreCategoryBloc bloc, StoryListType type) {
    final args = bloc.args;

    if (args is ExploreNovelCategoryArgument) {
      final initialRequest = args.request;
      return ExploreNovelPageWidget(
        request: initialRequest,
        listType: type,
      );
    }

    if (args is ExploreComicCategoryArgument) {
      final slug = args.categorySlug;
      return ExploreComicPageWidget(listType: type, categorySlug: slug);
    }

    return SizedBox();
  }
}
