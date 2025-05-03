import 'package:flutter/material.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/providers/async_value.dart';
import 'package:flutter_project/repository/user_repository.dart';
import 'package:logger/logger.dart';

class UserProvider extends ChangeNotifier {
  final UserRepository _userRepository;
  AsyncValue<List<User>>? userState;

  String? editingUserId;
  List<User> _userList = [];

  String _searchQuery = '';

  bool get isLoading =>
      userState != null && userState!.state == AsyncValueState.loading;

  bool get hasData =>
      userState != null && userState!.state == AsyncValueState.success;

  UserProvider(this._userRepository) {
    getUsers();
  }

  List<User> get userList {
    if (_searchQuery.isEmpty) return _userList;
    final lowerQuery = _searchQuery.toLowerCase();
    return _userList.where((user) {
      return user.name.toLowerCase().contains(lowerQuery) ||
          user.bibNumber.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  void getUsers() async {
    try {
      userState = AsyncValue.loading();
      notifyListeners();

      final users = await _userRepository.getAll();

      _userList = users;
      userState = AsyncValue.success(users);
    } catch (error) {
      Logger().d('Error fetching users: $error');
      userState = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void addUser(User user) async {
    editingUserId = '';
    _userList.add(user);
    notifyListeners();

    try {
      await _userRepository.add(user);
    } catch (e) {
      _userList.removeWhere((u) => u.id == user.id);
      notifyListeners();
      Logger().e('Failed to add user: $e');
    }
  }

  void updateUser(User user) {
    _userRepository.update(user);

    final index = _userList.indexWhere((u) => u.id == user.id);
    if (index != -1) {
      _userList[index] = user;
    }
    notifyListeners();
  }

  void deleteUser(User user) {
    _userRepository.remove(user.id);
    _userList.removeWhere((u) => u.id == user.id);

    notifyListeners();
  }

  void searchParticipant(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
