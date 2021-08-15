// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'car_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CarModel _$CarModelFromJson(Map<String, dynamic> json) {
  return _CarModel.fromJson(json);
}

/// @nodoc
class _$CarModelTearOff {
  const _$CarModelTearOff();

  _CarModel call({double? speed, int? doors}) {
    return _CarModel(
      speed: speed,
      doors: doors,
    );
  }

  CarModel fromJson(Map<String, Object> json) {
    return CarModel.fromJson(json);
  }
}

/// @nodoc
const $CarModel = _$CarModelTearOff();

/// @nodoc
mixin _$CarModel {
  double? get speed => throw _privateConstructorUsedError;
  int? get doors => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CarModelCopyWith<CarModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarModelCopyWith<$Res> {
  factory $CarModelCopyWith(CarModel value, $Res Function(CarModel) then) =
      _$CarModelCopyWithImpl<$Res>;
  $Res call({double? speed, int? doors});
}

/// @nodoc
class _$CarModelCopyWithImpl<$Res> implements $CarModelCopyWith<$Res> {
  _$CarModelCopyWithImpl(this._value, this._then);

  final CarModel _value;
  // ignore: unused_field
  final $Res Function(CarModel) _then;

  @override
  $Res call({
    Object? speed = freezed,
    Object? doors = freezed,
  }) {
    return _then(_value.copyWith(
      speed: speed == freezed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double?,
      doors: doors == freezed
          ? _value.doors
          : doors // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$CarModelCopyWith<$Res> implements $CarModelCopyWith<$Res> {
  factory _$CarModelCopyWith(_CarModel value, $Res Function(_CarModel) then) =
      __$CarModelCopyWithImpl<$Res>;
  @override
  $Res call({double? speed, int? doors});
}

/// @nodoc
class __$CarModelCopyWithImpl<$Res> extends _$CarModelCopyWithImpl<$Res>
    implements _$CarModelCopyWith<$Res> {
  __$CarModelCopyWithImpl(_CarModel _value, $Res Function(_CarModel) _then)
      : super(_value, (v) => _then(v as _CarModel));

  @override
  _CarModel get _value => super._value as _CarModel;

  @override
  $Res call({
    Object? speed = freezed,
    Object? doors = freezed,
  }) {
    return _then(_CarModel(
      speed: speed == freezed
          ? _value.speed
          : speed // ignore: cast_nullable_to_non_nullable
              as double?,
      doors: doors == freezed
          ? _value.doors
          : doors // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CarModel implements _CarModel {
  const _$_CarModel({this.speed, this.doors});

  factory _$_CarModel.fromJson(Map<String, dynamic> json) =>
      _$_$_CarModelFromJson(json);

  @override
  final double? speed;
  @override
  final int? doors;

  @override
  String toString() {
    return 'CarModel(speed: $speed, doors: $doors)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CarModel &&
            (identical(other.speed, speed) ||
                const DeepCollectionEquality().equals(other.speed, speed)) &&
            (identical(other.doors, doors) ||
                const DeepCollectionEquality().equals(other.doors, doors)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(speed) ^
      const DeepCollectionEquality().hash(doors);

  @JsonKey(ignore: true)
  @override
  _$CarModelCopyWith<_CarModel> get copyWith =>
      __$CarModelCopyWithImpl<_CarModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CarModelToJson(this);
  }
}

abstract class _CarModel implements CarModel {
  const factory _CarModel({double? speed, int? doors}) = _$_CarModel;

  factory _CarModel.fromJson(Map<String, dynamic> json) = _$_CarModel.fromJson;

  @override
  double? get speed => throw _privateConstructorUsedError;
  @override
  int? get doors => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CarModelCopyWith<_CarModel> get copyWith =>
      throw _privateConstructorUsedError;
}
