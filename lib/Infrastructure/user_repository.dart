import 'dart:convert';

import 'package:freezed_riverpod_api/Infrastructure/Model/user_model.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final http.Client _client;
  UserRepository(this._client);

  Future<List<User>> getUser(String url) async {
    final http.Response response = await _client.get(Uri.parse(url));
    final Iterable parsed = jsonDecode(response.body);
    final users = parsed.map((user) => User.fromJson(user)).toList();
    // final user = User.fromJson(parsed);
    return users;
  }
}