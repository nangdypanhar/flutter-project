import 'dart:convert';
import 'dart:io';

import 'package:flutter_project/dto/user_dto.dart';
import 'package:flutter_project/model/user.dart';
import 'package:flutter_project/repository/base_repository.dart';
import 'package:http/http.dart' as http;
import 'package:logger/web.dart';

class UserRepository extends BaseRepository<User> {
  static const String baseUrl =
      'https://flutter-project-b31fc-default-rtdb.asia-southeast1.firebasedatabase.app/users';

  @override
  Future<User> add(User user) async {
    Uri uri = Uri.parse('$baseUrl.json');

    final userJson = UserDto.toJson(user);
    final http.Response response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(userJson),
    );

    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to add user');
    }

    final newId = json.decode(response.body)['name'];
    final newUser = user.copyWith(id: newId);

    return newUser;
  }

  @override
  Future<List<User>> getAll() async {
    final uri = Uri.parse('$baseUrl.json');
    final response = await http.get(uri);

    if (response.statusCode != HttpStatus.ok &&
        response.statusCode != HttpStatus.created) {
      throw Exception('Failed to load users');
    }

    final data = json.decode(response.body) as Map<String, dynamic>?;

    if (data == null) {
      return [];
    }
    return data.entries
        .map((entry) => UserDto.fromJson(entry.key, entry.value))
        .toList();
  }

  @override
  Future<void> remove(String id) async {
    final Uri uri = Uri.parse('$baseUrl/$id.json');
    final response = await http.delete(uri);

    if (response.statusCode == HttpStatus.ok) {
      Logger().d('user deleted successfully!');
      await getAll();
    } else {
      throw Exception('Failed to delete user');
    }
  }

  @override
  Future<void> update(User user) async {
    final Uri uri = Uri.parse('$baseUrl/${user.id}.json');

    final Map<String, dynamic> updatedUser = UserDto.toJson(user);

    final response = await http.patch(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedUser),
    );

    if (response.statusCode == HttpStatus.ok) {
      Logger().d('User updated successfully!');
    } else {
      Logger().e('Failed to update user: ${response.body}');
      throw Exception('Failed to update user (Status: ${response.statusCode})');
    }
  }
}
