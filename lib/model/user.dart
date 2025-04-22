import 'package:uuid/uuid.dart';

class User {
  static final uuid = Uuid();

  final String userId;
  final String bibNumber;
  final String userName;
  final DateTime? finishedAt;
  User({
    required this.userName,
    required this.bibNumber,
    this.finishedAt,
  }) : userId = uuid.v4();
}
