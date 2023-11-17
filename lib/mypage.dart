import 'package:flutter/material.dart';

class Mypage extends StatelessWidget {
  const Mypage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "마이페이지",
          style: TextStyle(fontSize: 60),
        ),
      )
    );
  }
}