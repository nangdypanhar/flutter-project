import 'package:flutter/material.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/providers/user_provider.dart';

class ParticipantViewModel extends ChangeNotifier {
  final UserProvider userProvider;

  ParticipantViewModel(this.userProvider);

  void searchParticipant(String query) {
    userProvider.searchParticipant(query);
    notifyListeners();
  }

  void addUser(User user) {
    userProvider.addUser(user);
    notifyListeners();
  }

  void deleteUser(User user) {
    userProvider.deleteUser(user);
    notifyListeners();
  }

  List<User> get userList => userProvider.userList;
  bool get isLoading => userProvider.isLoading;
  bool get hasData => userProvider.hasData;

  String? editingUserId;

  bool isEditing(User user) => editingUserId == user.id;

  void startEditing(User user) {
    editingUserId = user.id;
    notifyListeners();
  }

  void saveEditing(User user) {
    editingUserId = '';
    userProvider.updateUser(user);
    notifyListeners();
  }
}
