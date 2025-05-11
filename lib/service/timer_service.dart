import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_project/model/event.dart';
import 'package:flutter_project/repository/event_repository.dart';

class TimerService {
  TimerService._internal();

  static final TimerService _instance = TimerService._internal();
  factory TimerService() => _instance;

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _timer;

  final ValueNotifier<Duration> elapsed = ValueNotifier(Duration.zero);
  bool get isRunning => _stopwatch.isRunning;

  DateTime? _startAt;
  DateTime? _finishAt;
  final EventRepository _eventRepository = EventRepository();

  void start() {
    _startAt = DateTime.now();
    _stopwatch.reset();
    _stopwatch.start();

    elapsed.value = _stopwatch.elapsed;

    _timer?.cancel();
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

  void finish() async {
    reset();
    _finishAt = DateTime.now();
    await _eventRepository.add(Event(startAt: _startAt!, finishAt: _finishAt!));
  }

  void reset() {
    pause();
    _stopwatch.reset();
    elapsed.value = Duration.zero;
  }
}
