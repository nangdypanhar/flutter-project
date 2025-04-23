import 'package:flutter_project/model/user.dart';

enum SportType { swimming, running, cycling }

class Event {
  final DateTime startTime;
  final DateTime endTime;
  final String eventId;
  final SportType sportType;
  List<User> participants;
  Event({
    required this.eventId,
    required this.sportType,
    required this.startTime,
    required this.endTime,
    this.participants = const [],
  });
}
