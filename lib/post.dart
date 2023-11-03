import 'package:flutter/material.dart';
import 'package:qj_projec/bottomNav.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "게시판",
          style: TextStyle(fontSize: 60),
        ),
      )
    );
  }
}