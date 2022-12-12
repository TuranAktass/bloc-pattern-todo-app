// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:auth_api/src/models/models.dart';

/// {@template auth_api}
/// The interface and models for an API providing authentication operations
/// {@endtemplate}
abstract class AuthApi {
  /// {@macro auth_api}
  const AuthApi();

  ///login
  Future<User> login({required Login login});

  ///register
  Future<User> register({required Register register});

  ///logout
  Future<void> logout();

  ///gets user info
  Stream<User> get user;

  ///get current user information
  User get currentUser;
}

///when the user has not logged in
class UserNotFoundException implements Exception {}
