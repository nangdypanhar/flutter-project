import 'package:flutter/material.dart';
import 'package:flutter_project/model/user.dart' show User;
import 'package:flutter_project/providers/async_value.dart';
import 'package:flutter_project/repository/user_repository.dart';
import 'package:logger/web.dart';

class ParticipantViewModel extends ChangeNotifier {
  final UserRepository _userRepository;
  AsyncValue<List<User>>? userState;

  String? editingUserId;
  List<User> _userList = [];
  List<User> _filteredUserList = [];

  bool get isLoading =>
      userState != null && userState!.state == AsyncValueState.loading;

  bool get hasData =>
      userState != null && userState!.state == AsyncValueState.success;

  ParticipantViewModel(this._userRepository) {
    getUsers();
  }

  List<User> get userList => _filteredUserList;

  bool isEditing(User user) => editingUserId == user.id;

  void getUsers() async {
    try {
      userState = AsyncValue.loading();
      notifyListeners();

      final users = await _userRepository.getAll();

      _userList = users;
      _filteredUserList = users;
      userState = AsyncValue.success(users);
    } catch (error) {
      Logger().d('Error fetching users: $error');
      userState = AsyncValue.error(error);
    }

    notifyListeners();
  }

  void addUser(User user) async {
    await _userRepository.add(user);
    getUsers();
  }

  void updateUser(User user) async {
    await _userRepository.update(user);
    getUsers();
  }

  void deleteUser(String id) async {
    await _userRepository.remove(id);
    getUsers();
  }

  void searchParticipant(String query) {
    if (query.isEmpty) {
      _filteredUserList = _userList;
    } else {
      _filteredUserList =
          _userList.where((user) {
            return user.name.toLowerCase().contains(query.toLowerCase()) ||
                user.bibNumber.toLowerCase().contains(query.toLowerCase());
          }).toList();
    }
    notifyListeners();
  }

  void startEditing(User user) {
    editingUserId = user.id;
    notifyListeners();
  }

  void saveEditing(User user) {
    editingUserId = null;
    updateUser(user);
  }
}
