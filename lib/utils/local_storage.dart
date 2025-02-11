import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToken(String token) async {
  final pers = await SharedPreferences.getInstance();
  await pers.setString('token', token);
}

Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  print('Token removed successfully');
}
