import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/features/explore/enum/explore_enum.dart';
import 'package:flutter_template/features/explore/widgets/explore_page_widget.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/page_view/app_page_view.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final _ = ref.watch(BlocProvider.explore);
    final t = context.t;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          t.exploreScreen.title,
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: AppPageView(
        isScrollTabView: true,
        isScrollable: true,
        onPageChanged: (index) {},
        items: ExploreEnum.values
            .map(
              (e) => AppPageViewItems(
                label: e.label(context),
                child: ExplorePageWidget(exploreEnum: e),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
