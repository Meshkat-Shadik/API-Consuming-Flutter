import 'dart:math';

import 'package:freezed_riverpod_api/infrastructure/Model/car_model/car_model.dart';
import 'package:riverpod/riverpod.dart';

class CarStateNotifier extends StateNotifier<CarModel> {
  CarStateNotifier() : super(CarModel(doors: 1, speed: 150));

  void setDoors(int doors) {
    final newState = state.copyWith(doors: doors);
    state = newState;
  }

  void increaseSpeed() {
    final newState = state.copyWith(speed: state.speed!.toInt() + 5);
    state = newState;
  }

  void brakeSpeed() {
    final speed = max(0, state.speed! - 30);
    final newState = state.copyWith(speed: speed.toDouble());
    state = newState;
  }
}
