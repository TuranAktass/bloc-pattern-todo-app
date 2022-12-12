// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:auth_api/auth_api.dart' as auth_api;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

/// {@template firebase_auth_api}
/// firebase implementation for authentication
/// {@endtemplate}
class FirebaseAuthApi extends auth_api.AuthApi {
  /// {@macro firebase_auth_api}
  FirebaseAuthApi();

  final _firebaseAuth = FirebaseAuth.instance;

  @override
  auth_api.User get currentUser {
    if (_firebaseAuth.currentUser == null) {
      throw auth_api.UserNotFoundException();
    } else {
      return auth_api.User(
        email: _firebaseAuth.currentUser!.email,
        id: _firebaseAuth.currentUser!.uid,
        name: _firebaseAuth.currentUser!.displayName,
      );
    }
  }

  @override
  Future<auth_api.User> login({required auth_api.Login login}) async {
    final user = await _firebaseAuth.signInWithEmailAndPassword(
      email: login.email,
      password: login.password,
    );

    if (user is FirebaseAuthException) {
      throw auth_api.UserNotFoundException();
    }

    return auth_api.User(
      email: user.user!.email,
      id: user.user!.uid,
      name: user.user!.displayName,
    );
  }

  @override
  Future<void> logout() async {
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.signOut();
    } else {
      throw auth_api.UserNotFoundException();
    }
  }

  @override
  Future<auth_api.User> register({required auth_api.Register register}) async {
    final user = await _firebaseAuth.createUserWithEmailAndPassword(
      email: register.email,
      password: register.password,
    );

    return auth_api.User(id: user.user!.uid, email: user.user?.email, name: '');
  }

  final _userStreamController =
      BehaviorSubject<auth_api.User>.seeded(auth_api.User.empty);

  @override
  Stream<auth_api.User> get user {
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        _userStreamController.add(
          auth_api.User(
            email: user.email,
            id: user.uid,
            name: user.displayName,
          ),
        );
      } else {
        _userStreamController.add(auth_api.User.empty);
      }
    });
    return _userStreamController.stream;
  }
}
