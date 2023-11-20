import 'package:flutter/material.dart';
import 'qjGpt_myJob.dart';
import 'qjGpt_newJob.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'qjGpt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/main',
      routes: {
        '/main': (context) => const CourseRecommend(),
        '/myJob': (context) => const MyLecture(),
        '/newJob': (context) => const OtherLecture(),
      },
    );
  }
}