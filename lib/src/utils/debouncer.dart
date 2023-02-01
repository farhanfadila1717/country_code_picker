import 'dart:async';

/// A custom debouncer function to delay the execution of a given callback
/// function.
///
/// The debouncer waits for a specified amount of time, [milliseconds]
/// before executing the callback.
/// If the [call] method is called multiple times before the [milliseconds]
/// have passed the previous callback is cancelled and a new timer is set
/// for the latest callback.
class Debouncer {
  /// Creates a new instance of [Debouncer].
  ///
  /// [milliseconds] specifies the amount of time to wait before executing
  /// the callback.
  Debouncer({
    required this.milliseconds,
  });

  /// Time delay in milliseconds
  final int milliseconds;
  Timer? _timer;

  /// Delays the execution of the [callback] by the specified [milliseconds].
  ///
  /// If the [call] method is called multiple times before the [milliseconds]
  /// have passed, the previous [callback] is cancelled and a new timer is set
  /// for the latest [callback].
  void call(void Function() callback) {
    _timer?.cancel();
    _timer = Timer(
      Duration(milliseconds: milliseconds),
      callback,
    );
  }
}
