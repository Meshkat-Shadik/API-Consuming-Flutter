import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:freezed_riverpod_api/Model/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:riverpod/riverpod.dart';

part 'api_state.freezed.dart';

//independent sources
final httpClientProvider =
    Provider<ApiClient>((ref) => ApiClient(http.Client()));

//dependent sources
final userStateNotifierProvider =
    StateNotifierProvider<UserStateNotifier, dynamic>(
        (ref) => UserStateNotifier(ref.watch(httpClientProvider)));

class UserStateNotifier extends StateNotifier<UserState> {
  final ApiClient apiClient;
  UserStateNotifier(this.apiClient) : super(UserState.initial());

  Future<void> getUser(String url) async {
    try {
      state = UserState.loading();
      var data = await apiClient.getUser(url);
      state = UserState.success(data);
    } catch (e) {
      state = UserState.error("$e");
    }
  }
}

class ApiClient {
  final http.Client _client;
  ApiClient(this._client);

  Future<List<User>> getUser(String url) async {
    final http.Response response = await _client.get(Uri.parse(url));
    final Iterable parsed = jsonDecode(response.body);
    final users = parsed.map((user) => User.fromJson(user)).toList();
    return users;
  }
}

@freezed
abstract class UserState with _$UserState {
  const factory UserState.initial() = _UserInitial;
  const factory UserState.loading() = _UserLoading;
  const factory UserState.success(List<User> user) = _UserLoadedSuccess;
  const factory UserState.error([String? message]) = _UserLoadedError;
}
