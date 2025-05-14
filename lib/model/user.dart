import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String bibNumber;
  final String name;
  final Duration? swimStartAt;
  final Duration? swimFinishAt;
  final Duration? runStartAt;
  final Duration? runFinishAt;
  final Duration? cyclingStartAt;
  final Duration? cyclingFinishAt;

  User({
    String? id,
    required this.name,
    required this.bibNumber,
    this.runStartAt,
    this.runFinishAt,
    this.cyclingStartAt,
    this.cyclingFinishAt,
    this.swimStartAt,
    this.swimFinishAt,
  }) : id = id ?? const Uuid().v4();

  User copyWith({
    String? id,
    String? bibNumber,
    String? name,
    Duration? swimStartAt,
    Duration? swimFinishAt,
    Duration? runStartAt,
    Duration? runFinishAt,
    Duration? cyclingStartAt,
    Duration? cyclingFinishAt,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      bibNumber: bibNumber ?? this.bibNumber,
      swimStartAt: swimStartAt ?? this.swimStartAt,
      swimFinishAt: swimFinishAt ?? this.swimFinishAt,
      runStartAt: runStartAt ?? this.runStartAt,
      runFinishAt: runFinishAt ?? this.runFinishAt,
      cyclingStartAt: cyclingStartAt ?? this.cyclingStartAt,
      cyclingFinishAt: cyclingFinishAt ?? this.cyclingFinishAt,
    );
  }
}
