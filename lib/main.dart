import 'package:flutter/material.dart';
import 'package:qj_projec/course_dic.dart';
import 'package:qj_projec/job_dic.dart';
import 'package:qj_projec/qjGpt_main.dart';

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