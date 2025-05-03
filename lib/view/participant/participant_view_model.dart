import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/providers/user_provider.dart';

class ParticipantViewModel extends UserProvider {
  ParticipantViewModel(super.userRepository);

  bool isEditing(User user) => editingUserId == user.id;

  void startEditing(User user) {
    editingUserId = user.id;
    notifyListeners();
  }

  void saveEditing(User user) {
    editingUserId = '';
    updateUser(user);
  }
}
