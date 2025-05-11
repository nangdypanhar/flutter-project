import 'dart:convert';
import 'dart:io';

import 'package:flutter_project/dto/event_dto.dart';
import 'package:flutter_project/model/event.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class EventRepository {
  static const String baseUrl =
      'https://flutter-project-b31fc-default-rtdb.asia-southeast1.firebasedatabase.app/events';

  Future<void> add(Event event) async {
    Uri uri = Uri.parse('$baseUrl.json');

    final userJson = EventDto.toJson(event);
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userJson),
    );

    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to add event');
    } else {
      Logger().d("Event saved: ${event.startAt} → ${event.finishAt}");
    }
  }
}
