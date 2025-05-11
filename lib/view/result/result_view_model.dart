import 'package:flutter/material.dart';
import 'package:flutter_project/helper/time_format.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/providers/async_value.dart';
import 'package:flutter_project/providers/user_provider.dart';

class ResultViewModel extends ChangeNotifier {
  final UserProvider userProvider;

  AsyncValue<List<User>>? get userState => userProvider.userState;
  bool get isLoading => userProvider.isLoading;

  Duration? getTotalTime(User user) {
    return getTotalTimeFromHelper(user);
  }

  ResultViewModel(this.userProvider);

  List<User> getRankedParticipants() {
    final usersWithTime = <User>[];
    final usersWithoutTime = <User>[];

    for (final user in userProvider.userList) {
      final totalTime = getTotalTime(user);
      (totalTime != null ? usersWithTime : usersWithoutTime).add(user);
    }

    usersWithTime.sort(
      (a, b) => getTotalTime(a)!.compareTo(getTotalTime(b)!),
    );

    return [...usersWithTime, ...usersWithoutTime];
  }
}
