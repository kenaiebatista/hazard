import 'package:flutter/material.dart';
import 'package:hazard/domain/entities/user_entity.dart';
import 'package:hazard/domain/usecases/login_usecase.dart';
import 'package:hazard/domain/usecases/register_user_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUsecase _login;
  final RegisterUserUsecase _registerUser;

  AuthProvider({
    required LoginUsecase login,
    required RegisterUserUsecase registerUser,
  }) : _login = login,
       _registerUser = registerUser;

  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<bool> login(String email, String password) async {
    final success = await _login(email, password);
    if (success) {
      _isAuthenticated = true;
      notifyListeners();
    }
    return success;
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    await _registerUser(UserEntity(name: name, email: email, password: password));
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
