import 'package:uuid/uuid.dart';

class User {
  final String id;
  final String bibNumber;
  final String name;
  final DateTime? swimStartAt;
  final DateTime? swimFinishAt;
  final DateTime? runStartAt;
  final DateTime? runFinishAt;
  final DateTime? cyclingStartAt;
  final DateTime? cyclingFinishAt;

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
    DateTime? swimStartAt,
    DateTime? swimFinishAt,
    DateTime? runStartAt,
    DateTime? runFinishAt,
    DateTime? cyclingStartAt,
    DateTime? cyclingFinishAt,
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
