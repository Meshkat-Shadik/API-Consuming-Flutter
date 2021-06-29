import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:freezed_riverpod_api/infrastructure/Model/user_model.dart';

part 'api_state.freezed.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState.initial() = _UserInitial;
  const factory UserState.loading() = _UserLoading;
  const factory UserState.success(List<User> user) = _UserLoadedSuccess;
  const factory UserState.error([String? message]) = _UserLoadedError;
}
