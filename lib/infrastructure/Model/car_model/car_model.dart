// To parse this JSON data, do
//
//     final carModel = carModelFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'car_model.freezed.dart';
part 'car_model.g.dart';

CarModel carModelFromJson(String str) => CarModel.fromJson(json.decode(str));

String carModelToJson(CarModel data) => json.encode(data.toJson());

@freezed
abstract class CarModel with _$CarModel {
    const factory CarModel({
        double? speed,
        int? doors,
    }) = _CarModel;

    factory CarModel.fromJson(Map<String, dynamic> json) => _$CarModelFromJson(json);
}
