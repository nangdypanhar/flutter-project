import 'package:flutter_project/model/event.dart';

class EventDto {
  static Event fromJson(String id, Map<String, dynamic> json) {
    return Event(
      id: id,
      startAt: DateTime.parse(json['startAt']),
      finishAt: DateTime.parse(json['finishAt']),
    );
  }

  static Map<String, dynamic> toJson(Event event) {
    return {
      'startAt': event.startAt.toIso8601String(),
      'finishAt': event.finishAt.toIso8601String(),
    };
  }
}
