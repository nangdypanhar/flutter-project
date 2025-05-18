import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String bibNumber;
  final String name;
  final Duration? runFinishAt;
  final Duration? swimFinishAt;
  final Duration? cyclingFinishAt;

  User({
    String? id,
    required this.name,
    required this.bibNumber,
    this.runFinishAt,
    this.swimFinishAt,
    this.cyclingFinishAt
  }) : id = id ?? const Uuid().v4();

  User copyWith({
    String? id,
    String? bibNumber,
    String? name,
    Duration? runFinishAt,
    Duration? swimFinishAt,
    Duration? cyclingFinishAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      bibNumber: bibNumber ?? this.bibNumber,
      runFinishAt: runFinishAt ?? this.runFinishAt,
      swimFinishAt: swimFinishAt ?? this.swimFinishAt,
      cyclingFinishAt: cyclingFinishAt ?? this.cyclingFinishAt,
    );
  }
}
