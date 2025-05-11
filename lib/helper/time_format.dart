import 'package:flutter_project/model/user.dart';

String formatTotalTime(Duration duration) {
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;
  final seconds = duration.inSeconds % 60;

  return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  // Ex : 6:10:00
}

String formatDuration(Duration duration) {
  final int hours = duration.inHours;
  final int minutes = duration.inMinutes % 60;
  final int seconds = duration.inSeconds % 60;
  // Calculate centiseconds (1 centisecond = 10 milliseconds)
  final int centiseconds = (duration.inMilliseconds ~/ 10) % 100;
  return '${hours.toString().padLeft(2, '0')}:'
      '${minutes.toString().padLeft(2, '0')}:'
      '${seconds.toString().padLeft(2, '0')}:'
      '${centiseconds.toString().padLeft(2, '0')}';

  // Ex: 6:10:05:83
}

Duration? getTotalTimeFromHelper(User user) {
  final finishes = [user.swimFinishAt, user.runFinishAt, user.cyclingFinishAt];
  final starts = [user.swimStartAt, user.runStartAt, user.cyclingStartAt];

  if (finishes.any((e) => e == null) || starts.any((e) => e == null)) {
    return null;
  }

  final latestFinish = finishes.cast<DateTime>().reduce(
    (a, b) => a.isAfter(b) ? a : b,
  );
  final earliestStart = starts.cast<DateTime>().reduce(
    (a, b) => a.isBefore(b) ? a : b,
  );

  return latestFinish.difference(earliestStart);
}
