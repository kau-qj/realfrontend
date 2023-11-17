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
      initialRoute: '/myJob',
      routes: {
        '/myJob': (context) => const CourseRecommend(),
        '/newJob': (context) => const OtherLecture(),
      },
    );
  }
}