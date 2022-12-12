import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

///login model
@JsonSerializable()
class Login {
  ///constructor
  const Login({required this.email, required this.password});

  ///user email for login
  final String email;

  ///user password for login
  final String password;

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}
