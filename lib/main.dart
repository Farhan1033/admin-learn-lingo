import 'package:admin_english_app/controller/add_video_controller.dart';
import 'package:admin_english_app/controller/auth_controller.dart';
import 'package:admin_english_app/services/add_video_services.dart';
import 'package:admin_english_app/services/auth_services.dart';
import 'package:admin_english_app/utils/local_storage.dart';
import 'package:admin_english_app/view/add_video_page.dart';
import 'package:admin_english_app/view/home_page.dart';
import 'package:admin_english_app/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => AuthController(authServices: AuthServices())),
        ChangeNotifierProvider(
          create: (context) =>
              AddVideoController(addVideoServices: AddVideoServices()),
        )
      ],
      child: MaterialApp(
        home: const AuthCheck(),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/login': (context) => LoginScreen(),
          '/home': (context) => const HomePage(),
          '/add-video' : (context) => const AddVideoScreen()
        },
      ),
    );
  }
}

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  Future<bool> checkAuth() async {
    final token = await getToken().then(
      (token) => token,
    );
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkAuth(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else {
          return snapshot.data == false ? LoginScreen() : const HomePage();
        }
      },
    );
  }
}
