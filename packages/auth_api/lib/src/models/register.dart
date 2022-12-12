import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

///register model
@JsonSerializable()
class Register {
  ///constructor
  const Register({required this.email, required this.password});

  ///user email for login
  final String email;

  ///user password for login
  final String password;

  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);
}
