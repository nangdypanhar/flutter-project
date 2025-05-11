import 'package:flutter_project/model/event.dart';

class EventDto {
  static Event fromJson(String id, Map<String, dynamic> json) {
    return Event(id: id, startAt: json['startAt'], finishAt: json['finishAt']);
  }

  static Map<String, dynamic> toJson(Event event) {
    return {'startAt': event.startAt, 'finishAt': event.finishAt};
  }
}
