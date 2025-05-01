import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/repository/base_repository.dart';

class UserRepository extends BaseRepository<User> {
  final List<User> _users = [];

  @override
  Future<User> add(User user) async {
    _users.add(user);
    return user;
  }

  @override
  Future<List<User>> getAll() async {
    return _users;
  }

  @override
  Future<void> remove(String id) async {
    _users.removeWhere((user) => user.id == id);
  }

  @override
  Future<void> update(User updatedUser) async {
    final index = _users.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      _users[index] = updatedUser;
    }
  }
}
