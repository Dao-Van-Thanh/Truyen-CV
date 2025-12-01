import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/features/story/list_chapter/list_chapter_bloc.dart';

class ListChapterAppBar extends ConsumerWidget {
  const ListChapterAppBar({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.listChapter);
    final args = bloc.args;

    return ObsBuilder(
      streams: [bloc.isSearchingSubject],
      builder: (context) {
        final isSearching = bloc.isSearchingSubject.value;

        return AppBar(
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            transitionBuilder: (Widget child, Animation<double> animation) {
              final offsetAnimation = Tween<Offset>(
                begin: const Offset(0.2, 0.0),
                end: Offset.zero,
              ).animate(animation);

              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: offsetAnimation,
                  child: child,
                ),
              );
            },
            child: isSearching
                ? _buildSearchField(
                    key: const ValueKey('searchField'),
                    bloc: bloc,
                  )
                : Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      args.storyName,
                      key: const ValueKey('titleText'),
                    ),
                  ),
          ),
          leading: isSearching
              ? BackButton(onPressed: bloc.onTapSearch)
              : const BackButton(),
          centerTitle: false,
          actions: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: isSearching
                  ? IconButton(
                      key: const ValueKey('closeBtn'),
                      icon: const Icon(Icons.clear),
                      onPressed: bloc.onTapSearch,
                    )
                  : IconButton(
                      key: const ValueKey('searchBtn'),
                      icon: const Icon(CupertinoIcons.search),
                      onPressed: bloc.onTapSearch,
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchField({required Key key, required ListChapterBloc bloc}) {
    return TextField(
      key: key,
      autofocus: true,
      controller: bloc.searchController,
      decoration: const InputDecoration(
        hintText: 'Tìm kiếm chương...',
        border: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
      style: const TextStyle(fontSize: 18),
    );
  }
}
