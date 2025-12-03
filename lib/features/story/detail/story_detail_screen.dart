import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';
import 'package:flutter_template/constants/constants.dart';
import 'package:flutter_template/constants/size_box.dart';
import 'package:flutter_template/features/story/detail/story_detail_bloc.dart';
import 'package:flutter_template/i18n/strings.g.dart';
import 'package:flutter_template/shared/utilities/string.dart';
import 'package:flutter_template/shared/widgets/cache_network_image/app_cache_network_image.dart';
import 'dart:ui' as ui;

import 'package:flutter_template/shared/widgets/gesture_detector/app_gesture_detector.dart';
import 'package:flutter_template/shared/widgets/refresh_indicator/app_refresh_indicator.dart';

class StoryDetailScreen extends ConsumerWidget {
  const StoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.storyDetail);
    final theme = Theme.of(context);
    final t = context.t;
    return ObsBuilder(
      streams: [
        bloc.isLoadingSubject,
        bloc.storyDetailSubject,
      ],
      builder: (context) {
        final storyDetail = bloc.storyDetailSubject.value;

        if (bloc.isLoadingSubject.value) {
          return Container(
            alignment: Alignment.center,
            color: theme.scaffoldBackgroundColor,
            child: CircularProgressIndicator(),
          );
        }

        if (storyDetail == null) {
          return Container(
            alignment: Alignment.center,
            color: theme.scaffoldBackgroundColor,
            child: Column(
              children: [
                Text(
                  t.storyDetail.loadingError,
                  style: theme.textTheme.bodyMedium,
                ),
                SizedBoxConstants.s4,
                ElevatedButton(
                  onPressed: () {
                    bloc.loadStoryDetail();
                  },
                  child: Text(t.storyDetail.retry),
                ),
              ],
            ),
          );
        }

        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: ObsBuilder(
              streams: [bloc.scrollBehaviorSubject],
              builder: (context) {
                final scrollPercent = bloc.scrollBehaviorSubject.value;
                final backgroundColor = theme.scaffoldBackgroundColor;
                final appBarColor =
                    backgroundColor.withValues(alpha: scrollPercent);

                final isDark = theme.brightness == Brightness.dark;

                final iconColor = scrollPercent < 0.5
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.black);

                final titleColor = scrollPercent < 0.5
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.black);

                return AppBar(
                  backgroundColor: appBarColor,
                  iconTheme: IconThemeData(
                    color: iconColor,
                  ),
                  centerTitle: false,
                  title: AppGestureDetector(
                    onTap: () {
                      bloc.scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: scrollPercent,
                      child: Text(
                        storyDetail.name ?? '',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: titleColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  actions: [
                    //button save to library
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark_border,
                        color: iconColor,
                      ),
                    ),
                    // button share
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                        color: iconColor,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          body: AppRefreshIndicator(
            onRefresh: () async {
              bloc.loadStoryDetail();
            },
            child: Builder(
              builder: (context) {
                return SingleChildScrollView(
                  controller: bloc.scrollController,
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        _getBackground(
                          context,
                          bloc,
                          imageUrl: storyDetail.thumb ?? '',
                          storyName: storyDetail.name ?? '',
                          author: storyDetail.author ?? '',
                          chapter:
                              '${t.storyDetail.chapters} ${storyDetail.totalChapter}',
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _getContent(
                                title: t.storyDetail.info,
                                content: '${storyDetail.author ?? ''}'
                                    '\n${storyDetail.translator ?? ''}'
                                    '\n${storyDetail.category}',
                              ),
                              SafeArea(
                                top: false,
                                child: _getContent(
                                  title: t.storyDetail.introduce,
                                  content: StringUtilities.clearHtml(
                                    storyDetail.description ?? '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          bottomNavigationBar: _buildBottomNavigationBar(context, bloc),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context, StoryDetailBloc bloc) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(
              color: theme.dividerColor,
              width: 0.25,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: AppGestureDetector(
                onTap: bloc.onTapNextListChapter,
                child: IntrinsicHeight(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                    ),
                    child: Column(
                      children: [
                        SizedBoxConstants.s8,
                        Icon(
                          Icons.menu_book,
                          color: theme.brightness == Brightness.dark
                              ? Colors.white70
                              : Colors.black87,
                        ),
                        SizedBoxConstants.s4,
                        Text(
                          t.storyDetail.tableOfContents,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.brightness == Brightness.dark
                                ? Colors.white70
                                : Colors.black87,
                          ),
                        ),
                        SizedBoxConstants.s4,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: AppGestureDetector(
                onTap: () {},
                child: Container(
                  color: theme.colorScheme.primary,
                  child: IntrinsicHeight(
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(),
                      child: Column(
                        children: [
                          SizedBoxConstants.s8,
                          Icon(
                            Icons.play_arrow,
                            color: theme.brightness == Brightness.dark
                                ? Colors.black87
                                : Colors.white70,
                          ),
                          SizedBoxConstants.s4,
                          Text(
                            t.storyDetail.readNow,
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.black87
                                  : Colors.white70,
                            ),
                          ),
                          SizedBoxConstants.s4,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getBackground(
    BuildContext context,
    StoryDetailBloc bloc, {
    required String imageUrl,
    required String storyName,
    required String author,
    required String chapter,
  }) {
    final appBarHeight = kToolbarHeight;

    return ClipRect(
      child: Container(
        width: double.infinity,
        height: 230,
        color: Colors.black,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Transform.scale(
                scale: 1.1,
                child: ImageFiltered(
                  imageFilter: ui.ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: AppCacheNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                  top: appBarHeight + 25,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.5),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: AspectRatio(
                        aspectRatio: 2 / 3,
                        child: AppCacheNetworkImage(
                          imageUrl: imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBoxConstants.s16,
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGestureDetector(
                            onTap: bloc.onTapCopyStoryName,
                            child: Text(
                              storyName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBoxConstants.s8,
                          Text(
                            '$author\n$chapter',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getContent({required String title, required String content}) {
    final contentText = content.isNotEmpty ? content : '...';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBoxConstants.s8,
          SelectableText(
            contentText,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
