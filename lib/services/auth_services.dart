import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:admin_english_app/model/auth_model.dart';
import 'package:admin_english_app/utils/server.dart';

class AuthServices {
  static const String loginEndpoint = "$baseUrl/auth/login";

  Future<String?> signIn(AuthModel authModel) async {
    try {
      final response = await http.post(
        Uri.parse(loginEndpoint),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'email': authModel.email,
          'password': authModel.password,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = jsonDecode(response.body);
        final token = jsonData['data']['token'] as String?;
        if (token != null) {
          return token;
        } else {
          throw Exception('Token not found in response');
        }
      } else {
        throw Exception('Failed to login: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in service: $e');
      throw Exception('Failed to login: $e');
    }
  }
}