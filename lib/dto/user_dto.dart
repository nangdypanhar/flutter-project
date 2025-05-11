import 'package:flutter_project/model/user.dart';
import 'package:logger/web.dart';

class UserDto {
  static DateTime? _parseDateTime(String? dateStr) {
    if (dateStr == null || dateStr == '') return null;
    try {
      return DateTime.parse(dateStr);
    } catch (e) {
      Logger().d("Error parsing DateTime: $dateStr | Error: $e");
      return null;
    }
  }

  static User fromJson(String id, Map<String, dynamic> json) {
    return User(
      id: id,
      name: json['name'] ?? '',
      bibNumber: json['bibNumber']?.toString() ?? '',
      runStartAt: _parseDateTime(json['runStartAt']),
      runFinishAt: _parseDateTime(json['runFinishAt']),
      swimStartAt: _parseDateTime(json['swimStartAt']),
      swimFinishAt: _parseDateTime(json['swimFinishAt']),
      cyclingStartAt: _parseDateTime(json['cyclingStartAt']),
      cyclingFinishAt: _parseDateTime(json['cyclingFinishAt']),
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'name': user.name,
      'bibNumber': user.bibNumber,
      'runStartAt': user.runStartAt?.toIso8601String() ?? '',
      'runFinishAt': user.runFinishAt?.toIso8601String() ?? '',
      'swimStartAt': user.swimStartAt?.toIso8601String() ?? '',
      'swimFinishAt': user.swimFinishAt?.toIso8601String() ?? '',
      'cyclingStartAt': user.cyclingStartAt?.toIso8601String() ?? '',
      'cyclingFinishAt': user.cyclingFinishAt?.toIso8601String() ?? '',
    };
  }
}
