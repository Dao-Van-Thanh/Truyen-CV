import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension StreamAutoDisposeExt<T> on Stream<T> {
  // Binds the stream subscription to the lifecycle of the provided Ref.
  StreamSubscription<T> bind(
    Ref ref,
    void Function(T event) onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    final subscription = listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );

    /// Dispose the subscription when the Ref is disposed.
    ref.onDispose(() {
      subscription.cancel();
    });

    return subscription;
  }
}
