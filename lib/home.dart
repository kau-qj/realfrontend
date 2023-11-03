import 'package:flutter/material.dart';
import 'package:qj_projec/bottomNav.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "홈",
          style: TextStyle(fontSize: 60),
        ),
      )
    );
  }
}