import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truyen_cv/bloc/bloc_provider.dart';
import 'package:truyen_cv/bloc/rx/obs_builder.dart';
import 'package:truyen_cv/features/story/read_comic/entities/comic_chapter_entity.dart';
import 'package:truyen_cv/features/story/read_comic/read_comic_bloc.dart';

class ReadComicController extends ConsumerWidget {
  const ReadComicController({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloc = ref.watch(BlocProvider.readComic);

    return ObsBuilder(
      streams: [
        bloc.isMenuVisibleSubject,
        bloc.currentChapterSubject,
        bloc.isFavoriteSubject,
      ],
      builder: (context) {
        final isVisible = bloc.isMenuVisibleSubject.value;
        final currentChapter = bloc.currentChapterSubject.value;

        return Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              top: isVisible ? 0 : -120,
              left: 0,
              right: 0,
              child: _buildTopBar(
                context: context,
                chapter: currentChapter,
                onTapBookmark: bloc.onTapFavoriteStory,
                isFavorite: bloc.isFavoriteSubject.value,
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              bottom: isVisible ? 0 : -150,
              left: 0,
              right: 0,
              child: _buildBottomBar(context, bloc),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTopBar({
    required BuildContext context,
    ComicChapterEntity? chapter,
    required VoidCallback onTapBookmark,
    required bool isFavorite,
  }) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          color: Colors.black.withValues(alpha: 0.75),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 8,
            bottom: 12,
            left: 4,
            right: 4,
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: () => Navigator.of(context).maybePop('FORCE_EXIT'),
              ),
              Expanded(
                child: Text(
                  chapter?.name ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: onTapBookmark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context, ReadComicBloc bloc) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          color: Colors.black.withValues(alpha: 0.75),
          padding: EdgeInsets.only(
            top: 16,
            bottom: MediaQuery.of(context).padding.bottom + 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActionButton(
                icon: Icons.skip_previous_rounded,
                label: 'Chương trước',
                onTap: bloc.onTapPreviousPage,
              ),
              _buildActionButton(
                icon: Icons.format_list_bulleted_rounded,
                label: 'Mục lục',
                onTap: bloc.onTapToggleDrawer,
              ),
              _buildActionButton(
                icon: Icons.skip_next_rounded,
                label: 'Chương sau',
                onTap: bloc.onTapNextPage,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        splashColor: Colors.white.withValues(alpha: 0.1),
        highlightColor: Colors.white.withValues(alpha: 0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.white, size: 26),
              const SizedBox(height: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
