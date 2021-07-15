//independent sources
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_riverpod_api/Api/api_state.dart';
import 'package:freezed_riverpod_api/Application/userNotifier.dart';
import 'package:freezed_riverpod_api/infrastructure/userRepository.dart';
import 'package:http/http.dart' as http;

final httpClientProvider =
    Provider<UserRepository>((ref) => UserRepositoryImpl(http.Client()));

//dependent sources
final userStateNotifierProvider =
    StateNotifierProvider<UserStateNotifier, UserState>(
        (ref) => UserStateNotifier(ref.watch(httpClientProvider)));
