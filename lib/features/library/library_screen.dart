import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/features/library/widgets/library_bookmarks_page.dart';
import 'package:flutter_template/features/library/widgets/library_history_page.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/widgets/page_view/app_page_view.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final t = context.t;
    final bloc = ref.watch(BlocProvider.library);
    return Scaffold(
      body: ObsBuilder(
        streams: [bloc.isLoadingSubject],
        builder: (context) {
          if (bloc.isLoadingSubject.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: AppPageView(
              isScrollTabView: true,
              isScrollable: true,
              dividerColor: Colors.transparent,
              leading: Padding(
                padding: EdgeInsetsConstants.left16 +
                    EdgeInsetsConstants.right12 +
                    EdgeInsetsConstants.top8,
                child: SizedBox(
                  height: 32,
                  width: 32,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: const AssetImage(
                      CommonConstants.avatarDefaultPath,
                    ),
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: bloc.onTapSearch,
                  icon: Icon(
                    CupertinoIcons.search,
                    size: 20,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'add_story') {
                      bloc.onTapAddStory();
                    }
                  },
                  icon: Icon(
                    Icons.more_vert,
                    size: 20,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  itemBuilder: (BuildContext context) => [
                    PopupMenuItem<String>(
                      value: 'add_story',
                      child: Row(
                        children: [
                          Icon(
                            Icons.folder_open,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          SizedBox(width: 8),
                          Text('Thêm truyện'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              items: [
                AppPageViewItems(
                  label: t.libraryScreen.bookmarks,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  child: const LibraryBookmarksPage(),
                ),
                AppPageViewItems(
                  label: t.libraryScreen.history,
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                  child: const LibraryHistoryPage(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
