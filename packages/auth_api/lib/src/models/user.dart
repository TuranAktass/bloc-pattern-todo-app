import 'package:equatable/equatable.dart';

///user model
class User extends Equatable {
  ///constructor for current user
  const User({required this.id, this.name, this.email});

  ///current user id
  final String id;

  ///current user's email
  final String? email;

  ///Current user's name
  final String? name;

  ///unauthenticated user
  static const empty = User(id: '');

  ///if user is empty return true
  bool get isEmpty => this == User.empty;

  ///if user is not empty return true
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [email, id, name];
}
