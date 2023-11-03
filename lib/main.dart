import 'package:flutter/material.dart';

import 'package:qj_projec/job_dic.dart';
import 'package:qj_projec/home.dart';
import 'package:qj_projec/mypage.dart';
import 'package:qj_projec/qjGpt_main.dart';
import 'package:qj_projec/post.dart';
import 'package:qj_projec/bottomNav.dart';

import 'package:qj_projec/httpApi/api_hompage.dart';
import 'package:qj_projec/httpApi/api_qjGpt.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {    
    return MaterialApp(
      home: MyButtomNaVBar(),
    );
  }
}