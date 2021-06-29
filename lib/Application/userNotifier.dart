import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_riverpod_api/Api/api_state.dart';
import 'package:freezed_riverpod_api/infrastructure/userRepository.dart';

class UserStateNotifier extends StateNotifier<UserState> {
  final UserRepository userRepository;
  UserStateNotifier(this.userRepository) : super(UserState.initial());
  Future<void> getUser(String url) async {
    try {
      state = UserState.loading();
      var data = await userRepository.getUser(url);
      state = UserState.success(data);
    } catch (e) {
      state = UserState.error("$e");
    }
  }
}
