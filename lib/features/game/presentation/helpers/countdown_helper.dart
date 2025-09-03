import 'dart:async';

import 'package:riverpod/riverpod.dart';

class CountdownHelper {
  final int seconds;
  Timer? _timer;
  final _controller = StreamController<int>();
  Stream<int> get stream => _controller.stream;

  CountdownHelper({required this.seconds});

  Future<void> start(Future<void> Function() fn) async {
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

    await Future.wait([Future.delayed(Duration(seconds: seconds)), fn()]);
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
