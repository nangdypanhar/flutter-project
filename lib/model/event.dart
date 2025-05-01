import 'package:flutter_project/model/user.dart';

class Event {
  final String id;
  final DateTime startTime;
  final DateTime endTime;

  final List<User> participants;
  Event({
    required this.id,
    required this.startTime,
    required this.endTime,
    this.participants = const [],
  });
}
