import 'package:flutter/material.dart';

enum StoryListType { grid, list, listCompact }

extension StoryListTypeExtension on StoryListType {
  bool get isGrid => this == StoryListType.grid;
  bool get isList =>
      this == StoryListType.list || this == StoryListType.listCompact;

  Widget get icon {
    switch (this) {
      case StoryListType.grid:
        return const Icon(Icons.grid_view);
      case StoryListType.list:
        return const Icon(Icons.view_list);
      case StoryListType.listCompact:
        return const Icon(Icons.view_list_outlined);
    }
  }
}
