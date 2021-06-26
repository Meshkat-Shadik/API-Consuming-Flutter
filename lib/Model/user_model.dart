import 'package:json_annotation/json_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';
@freezed
abstract class User with _$User{
  const factory User({required String name, required String username,required String email}) = _User;
   factory User.fromJson(Map<String,dynamic>json)=>_$UserFromJson(json);
}