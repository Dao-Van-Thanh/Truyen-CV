import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BlocBase {
  bool isDispose = false;

  void dispose() {
    isDispose = true;
  }
}

AutoDisposeProvider<T> createAutoDisposeBloc<T extends BlocBase>(
  T Function(Ref ref) blocFunction,
) {
  return Provider.autoDispose<T>((ref) {
    final bloc = blocFunction(ref);
    ref.onDispose(() {
      bloc.dispose();
    });
    return bloc;
  });
}
