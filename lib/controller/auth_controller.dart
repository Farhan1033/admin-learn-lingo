import 'package:flutter/material.dart';
import 'package:admin_english_app/model/auth_model.dart';
import 'package:admin_english_app/services/auth_services.dart';
import 'package:admin_english_app/utils/local_storage.dart';

class AuthController with ChangeNotifier {
  final AuthServices authServices;

  AuthController({required this.authServices});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await authServices
          .signIn(AuthModel(email: email, password: password));

      if (token != null) {
        saveToken(token);
        print('Token saved: $token');
      } else {
        print('Token not saved');
        throw Exception('Token is null');
      }
    } catch (e) {
      print('Exception in controller: $e');
      throw Exception('Failed to login: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
