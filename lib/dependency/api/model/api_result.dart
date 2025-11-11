enum ApiStatus { success, error, handled }

class ApiResult<T> {
  final ApiStatus status;
  final T? data;
  final Object? error;

  ApiResult._(this.status, {this.data, this.error});

  // Factory constructors
  factory ApiResult.success(T data) =>
      ApiResult._(ApiStatus.success, data: data);

  factory ApiResult.error(Object error, {T? data}) =>
      ApiResult._(ApiStatus.error, error: error, data: data);

  factory ApiResult.handled() => ApiResult._(ApiStatus.handled);

  // Convenience getters
  bool get hasData => status == ApiStatus.success && data != null;

  bool get hasError => status == ApiStatus.error && error != null;

  bool get isHandled => status == ApiStatus.handled;

  (T?, Object?) get toTuple => (data, error);

  // Classic exhaustive `when`
  R when<R>({
    required R Function(T data) success,
    required R Function(Object error) error,
    required R Function() handled,
  }) {
    switch (status) {
      case ApiStatus.success:
        return success(data as T);
      case ApiStatus.error:
        return error(this.error!);
      case ApiStatus.handled:
        return handled();
    }
  }

  // Flexible version: maybeWhen (with fallback)
  R maybeWhen<R>({
    R Function(T data)? success,
    R Function(Object error)? error,
    R Function()? handled,
    required R Function() orElse,
  }) {
    switch (status) {
      case ApiStatus.success:
        return success != null ? success(data as T) : orElse();
      case ApiStatus.error:
        return error != null ? error(this.error!) : orElse();
      case ApiStatus.handled:
        return handled != null ? handled() : orElse();
    }
  }

  // Super short version: whenOrNull (no orElse)
  R? whenOrNull<R>({
    R Function(T data)? success,
    R Function(Object error)? error,
    R Function()? handled,
  }) {
    switch (status) {
      case ApiStatus.success:
        return success?.call(data as T);
      case ApiStatus.error:
        return error?.call(this.error!);
      case ApiStatus.handled:
        return handled?.call();
    }
  }

  @override
  String toString() => 'ApiResult(status: $status, data: $data, error: $error)';
}
