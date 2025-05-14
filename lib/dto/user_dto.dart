import 'package:flutter_project/helper/time_format.dart';
import 'package:flutter_project/model/user.dart';
import 'package:logger/web.dart';

class UserDto {
  static Duration? _parseDuration(String? durationStr) {
    if (durationStr == null || durationStr == '') return null;
    try {
      final parts = durationStr.split(':');
      final hours = int.parse(parts[0]);
      final minutes = int.parse(parts[1]);
      final seconds = int.parse(parts[2]);
      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    } catch (e) {
      Logger().d("Error parsing Duration: $durationStr | Error: $e");
      return null;
    }
  }

  static User fromJson(String id, Map<String, dynamic> json) {
    return User(
      id: id,
      name: json['name'] ?? '',
      bibNumber: json['bibNumber']?.toString() ?? '',
      runStartAt: _parseDuration(json['runStartAt']),
      runFinishAt: _parseDuration(json['runFinishAt']),
      swimStartAt: _parseDuration(json['swimStartAt']),
      swimFinishAt: _parseDuration(json['swimFinishAt']),
      cyclingStartAt: _parseDuration(json['cyclingStartAt']),
      cyclingFinishAt: _parseDuration(json['cyclingFinishAt']),
    );
  }

  static Map<String, dynamic> toJson(User user) {
    Logger().d("Converting user to JSON: ${user.name}");
    return {
      'name': user.name,
      'bibNumber': user.bibNumber,
      'runStartAt': formatTotalTime(user.runStartAt ?? Duration.zero),
      'runFinishAt': formatTotalTime(user.runFinishAt ?? Duration.zero),
      'swimStartAt': formatTotalTime(user.swimStartAt ?? Duration.zero),
      'swimFinishAt': formatTotalTime(user.swimFinishAt ?? Duration.zero),
      'cyclingStartAt': formatTotalTime(user.cyclingStartAt ?? Duration.zero),
      'cyclingFinishAt': formatTotalTime(user.cyclingFinishAt ?? Duration.zero),
    };
  }
}
