import 'package:freezed_riverpod_api/Infrastructure/Model/user_model.dart';
import 'package:freezed_riverpod_api/Infrastructure/user_repository.dart';

import 'package:http/http.dart' as http;

import 'package:riverpod/riverpod.dart';

final userProvider = Provider((ref) => UserRepository(http.Client()));

final userFutureProvider =
    FutureProvider.autoDispose.family<List<User>, String>((ref, url) async {
  final httpClient = ref.read(userProvider);
  return httpClient.getUser(url);
});
