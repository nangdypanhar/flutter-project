import 'package:flutter/material.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/providers/async_value.dart';
import 'package:flutter_project/repository/user_repository.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository;
  AsyncValue<List<User>>? userState;

  UserProvider(this._userRepository) {
    getUsers();
  }

  bool get isLoading =>
      userState != null && userState!.state == AsyncValueState.loading;
  bool get hasData =>
      userState != null && userState!.state == AsyncValueState.success;

  void getUsers() async {
    try {
      userState = AsyncValue.loading();
      notifyListeners();

      userState = AsyncValue.success(await _userRepository.getAll());
    } catch (error) {
      userState = AsyncValue.error(error);
    } finally {
      notifyListeners();
    }
  }

  void addUser(User user) async {
    await _userRepository.add(user);
    getUsers();
  }

  void removeUser(String id) async {
    await _userRepository.remove(id);
    getUsers();
  }

  void updateUser(User user) async {
    await _userRepository.update(user);
    getUsers();
  }
}
