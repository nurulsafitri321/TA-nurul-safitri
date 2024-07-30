import 'package:flutter/material.dart';
import 'package:mentoring_app/singup_login/sign_in.dart';
import 'package:mentoring_app/singup_login/sign_up.dart';
import 'package:mentoring_app/welcome/main_page.dart';

import 'package:mentoring_app/welcome/welcome_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navbar App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/signin': (context) => const SignIn(),
        '/signup': (context) => const SignUp(),
        '/login': (context) => const SignIn(),
        '/main': (context) => const MainPage(),
      },
    );
  }
}
