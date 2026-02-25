import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/dependency/network_api/novel/filter/story_filter_request.dart';
import 'package:flutter_template/features/explore/enum/explore_novel_type.dart';
import 'package:flutter_template/features/explore/widgets/category_page_widget.dart';
import 'package:flutter_template/features/explore/widgets/explore_page_widget.dart';
import 'package:flutter_template/shared/widgets/page_view/app_page_view.dart';

class ExploreNovelScreen extends ConsumerWidget {
  const ExploreNovelScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final appConfigBloc = ref.watch(BlocProvider.config);
    return Scaffold(
      body: ObsBuilder(
        streams: [appConfigBloc.typeListDisplaySubject],
        builder: (context) {
          return AppPageView(
            isScrollTabView: true,
            isScrollable: true,
            onPageChanged: (index) {},
            items: ExploreNovelType.values.map(
              (e) {
                if (e == ExploreNovelType.genres) {
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
      ),
    );
  }
}
