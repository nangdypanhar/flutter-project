import 'package:uuid/uuid.dart';

class Event {
  final String id;
  final DateTime startAt;
  final DateTime finishAt;

  Event({
    String? id,
    required this.startAt,
    required this.finishAt,
  }) : id = id ?? const Uuid().v4();

  Event copyWith({
    String? id,
    DateTime? startAt,
    DateTime? finishAt,
  }) {
    return Event(
      id: id ?? this.id,
      startAt: startAt ?? this.startAt,
      finishAt: finishAt ?? this.finishAt,
    );
  }
}
