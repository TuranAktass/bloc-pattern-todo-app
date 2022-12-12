// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:auth_api/auth_api.dart';

/// {@template auth_repository}
/// auth_repository
/// {@endtemplate}
class AuthRepository {
  /// {@macro auth_repository}
  const AuthRepository({required AuthApi authApi}) : _authApi = authApi;

  final AuthApi _authApi;

  /// Returns the user state changes.
  Stream<User> get user => _authApi.user;

  /// login
  Future<User> login({required Login login}) => _authApi.login(login: login);

  /// logout
  Future<void> logout() => _authApi.logout();

  ///returns the curren user
  User get currentUser => _authApi.currentUser;

  ///register
  Future<User> register({required Register register}) =>
      _authApi.register(register: register);
}
