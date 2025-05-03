import 'package:flutter_project/model/user.dart';

class UserDto {
  static User fromJson(String id, Map<String, dynamic> json) {
    return User(
      id: id,
      name: json['name'] ?? '',
      bibNumber: json['bibNumber']?.toString() ?? '',
      runStartAt: json['runStartAt'],
      runFinishAt: json['runFinishAt'],
      swimStartAt: json['swimStartAt'],
      swimFinishAt: json['swimFinishAt'],
      cyclingStartAt: json['cyclingStartAt'],
      cyclingFinishAt: json['cyclingFinishAt'],
    );
  }

  static Map<String, dynamic> toJson(User user) {
    return {
      'name': user.name,
      'bibNumber': user.bibNumber,
      'runStartAt': user.runStartAt,
      'runFinishAt': user.runFinishAt,
      'swimStartAt': user.swimStartAt,
      'swimFinishAt': user.swimFinishAt,
      'cyclingStartAt': user.cyclingStartAt,
      'cyclingFinishAt': user.cyclingFinishAt,
    };
  }
}
