
import 'dart:async';
import 'package:flutter/foundation.dart';

class TimerService {
  TimerService._internal();

  static final TimerService _instance = TimerService._internal();
  factory TimerService() => _instance;

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;


  final ValueNotifier<Duration> elapsed = ValueNotifier(Duration.zero);

  bool get isRunning => _stopwatch.isRunning;


  void start() {
    _stopwatch.reset();
    _stopwatch.start();
    _timer?.cancel();
    // Update every 10 milliseconds to capture centiseconds.
    _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
      elapsed.value = _stopwatch.elapsed;
    });
  }


  void pause() {
    _timer?.cancel();
    _stopwatch.stop();
  }

  void resume() {
    if (!_stopwatch.isRunning && _stopwatch.elapsed > Duration.zero) {
      _stopwatch.start();
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(milliseconds: 10), (_) {
        elapsed.value = _stopwatch.elapsed;
      });
    }
  }


  void stop() {
    _timer?.cancel();
    _stopwatch.stop();
  }


  void reset() {
    stop();
    _stopwatch.reset();
    elapsed.value = Duration.zero;
  }
}