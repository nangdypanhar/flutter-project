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

Duration getTotalDurationForUser(User user) {
  Duration totalDuration = Duration.zero;

  if (user.swimFinishAt != Duration.zero &&
      user.runFinishAt != Duration.zero &&
      user.cyclingFinishAt != Duration.zero) {
    return totalDuration =
        user.swimFinishAt! + user.runFinishAt! + user.cyclingFinishAt!;
  }

  return totalDuration;
}
