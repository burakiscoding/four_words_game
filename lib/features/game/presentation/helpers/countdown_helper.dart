import 'dart:async';

import 'package:riverpod/riverpod.dart';

/// A helper class that manages a countdown timer and async tasks together
/// Emits countdown values through [Stream]
/// Run an async function in parallel with the countdown
/// Designed to be used with Riverpod but works standalone as well
/// The main purpose of this class is to run async functions while performing a countdown
class CountdownHelper {
  final int seconds;
  Timer? _timer;
  final _controller = StreamController<int>.broadcast();
  Stream<int> get stream => _controller.stream;

  CountdownHelper({required this.seconds});

  Future<T> start<T>(Future<T> Function() fn) async {
    int count = seconds;
    _controller.add(count);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      count--;
      if (count > 0) {
        _controller.add(count);
      } else {
        _timer?.cancel();
        _timer = null;
      }
    });

    final results = await Future.wait([Future.delayed(Duration(seconds: seconds)), fn()]);
    return results[1] as T;
  }

  void dispose() {
    _controller.close();
    _timer?.cancel();
    _timer = null;
  }
}

final countdownHelperProvider = Provider.autoDispose.family<CountdownHelper, int>((ref, seconds) {
  return CountdownHelper(seconds: seconds);
});
