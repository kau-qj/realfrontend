import 'package:flutter/material.dart';
import 'package:qj_projec/bottomNav.dart';
import 'package:qj_projec/login_page/login_page.dart';
import 'package:qj_projec/login_page/signup_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login', // 초기 경로 설정
      routes: {
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => MyButtomNaVBar(),
      },
    );
  }
}