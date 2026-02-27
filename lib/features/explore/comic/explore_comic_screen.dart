import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/features/explore/comic/widget/explore_comic_page_widget.dart';
import 'package:flutter_template/features/explore/enum/explore_comic_type.dart';
import 'package:flutter_template/features/explore/widgets/category_page_widget.dart';
import 'package:flutter_template/shared/widgets/page_view/app_page_view.dart';

class ExploreComicScreen extends ConsumerWidget {
  const ExploreComicScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appConfigBloc = ref.watch(BlocProvider.config);
    final bloc = ref.watch(BlocProvider.exploreComic);
    return ObsBuilder(
      streams: [
        appConfigBloc.typeListDisplaySubject,
      ],
      builder: (context) {
        return AppPageView(
          isScrollTabView: true,
          isScrollable: true,
          onPageChanged: (index) {},
          items: ExploreComicType.values.map(
            (e) {
              if (e == ExploreComicType.genres) {
                return AppPageViewItems(
                  key: ValueKey('categoryPage_${e.displayName}'),
                  label: e.displayName,
                  child: ObsBuilder(
                    streams: [
                      bloc.isLoadingCategorySubject,
                      bloc.listCategorySubject,
                    ],
                    builder: (context) {
                      return CategoryPageWidget(
                        isLoading: bloc.isLoadingCategorySubject.value,
                        listCategory: bloc.listCategorySubject.value,
                        onSelectCategory: (category) {
                          bloc.onSelectCategory(category.id);
                        },
                      );
                    },
                  ),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                );
              }
              return AppPageViewItems(
                label: e.displayName,
                child: ExploreComicPageWidget(
                  key: ValueKey('explorePage_${e.displayName}'),
                  categorySlug: e.slug,
                  listType: appConfigBloc.typeListDisplaySubject.value,
                ),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}
