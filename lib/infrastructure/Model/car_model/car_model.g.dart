// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CarModel _$_$_CarModelFromJson(Map<String, dynamic> json) {
  return _$_CarModel(
    speed: (json['speed'] as num?)?.toDouble(),
    doors: json['doors'] as int?,
  );
}

Map<String, dynamic> _$_$_CarModelToJson(_$_CarModel instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'doors': instance.doors,
    };
