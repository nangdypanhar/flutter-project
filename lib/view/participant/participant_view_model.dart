import 'package:flutter/material.dart';
import 'package:flutter_project/model/user.dart' show User;
import 'package:flutter_project/repository/user_repository.dart';

class ParticipantViewModel extends ChangeNotifier {
  final UserRepository _userRepository;

  String? editingUserId;
  List<User> _userList = [];
  List<User> _filteredUserList = [];

  ParticipantViewModel(this._userRepository) {
    getUsers();
  }

  List<User> get userList => _filteredUserList;

  bool isEditing(User user) => editingUserId == user.id;

  Future<void> getUsers() async {
    try {
      _userList = await _userRepository.getAll();
      _filteredUserList = _userList;
      notifyListeners();
    } catch (error) {
      throw Exception("Failed to load users: $error");
    }
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
