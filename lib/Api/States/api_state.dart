import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:freezed_riverpod_api/Model/user_model.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:riverpod/riverpod.dart';


final httpClientProvider = Provider((ref) => ApiClient(http.Client()));

final responseProvider =
    FutureProvider.autoDispose.family<List<User>, String>((ref, url) async {
  final httpClient = ref.read(httpClientProvider);
  return httpClient.getUser(url);
});

class ApiClient {
  final http.Client _client;
  ApiClient(this._client);

  Future<List<User>> getUser(String url) async {
    final http.Response response = await _client.get(Uri.parse(url));
    final Iterable parsed = jsonDecode(response.body);
    final users = parsed.map((user) => User.fromJson(user)).toList();
    // final user = User.fromJson(parsed);
    return users;
  }
}
