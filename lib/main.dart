import 'package:flutter/material.dart';
import 'package:qj_projec/dictionary/course_dic.dart';
import 'package:qj_projec/dictionary/job_dic.dart';
import 'package:qj_projec/qjGpt/qjGpt_main.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    return MaterialApp(
      home: CourseRecommend(),

    );

  }
}