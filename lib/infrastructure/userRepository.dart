import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:freezed_riverpod_api/infrastructure/Model/user_model.dart';

abstract class UserRepository {
  Future<List<User>> getUser(String url);
}

class UserRepositoryImpl implements UserRepository {
  final http.Client _client;
  UserRepositoryImpl(this._client);

  @override
  Future<List<User>> getUser(String url) async {
    final http.Response response = await _client.get(Uri.parse(url));
    final Iterable parsed = jsonDecode(response.body);
    final users = parsed.map((user) => User.fromJson(user)).toList();
    return users;
  }
}
