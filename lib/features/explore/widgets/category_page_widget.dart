import 'package:flutter/material.dart';

class CategoryPageWidgetItem {
  final String id;
  final String categoryName;

  CategoryPageWidgetItem({
    required this.id,
    required this.categoryName,
  });
}

class CategoryPageWidget extends StatelessWidget {
  final bool isLoading;
  final List<CategoryPageWidgetItem> listCategory;
  final void Function(CategoryPageWidgetItem item) onSelectCategory;
  const CategoryPageWidget({
    super.key,
    required this.listCategory,
    required this.onSelectCategory,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final categories = listCategory;

    return SafeArea(
      top: false,
      child: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onSelectCategory(categories[index]),
            child: Container(
              decoration: BoxDecoration(
                color:
                    Theme.of(context).colorScheme.scrim.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(categories[index].categoryName),
              ),
            ),
          );
        },
      ),
    );
  }
}
