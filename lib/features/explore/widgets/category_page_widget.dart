import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/bloc/bloc_provider.dart';
import 'package:flutter_template/bloc/rx/obs_builder.dart';

class CategoryPageWidget extends ConsumerWidget {
  const CategoryPageWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final bloc = ref.watch(BlocProvider.explore);
    return ObsBuilder(
      streams: [bloc.categoriesSubject, bloc.isLoadingSubject],
      builder: (context) {
        if (bloc.isLoadingSubject.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final categories = bloc.categoriesSubject.value;
        return GridView.builder(
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
              onTap: () => bloc.onSelectCategory(categories[index]),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .scrim
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(categories[index].name ?? ''),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
