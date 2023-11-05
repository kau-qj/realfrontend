import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qj_projec/bottomNav.dart';
import 'package:qj_projec/httpApi/api_qjGpt.dart';

class CourseRecommend extends StatefulWidget {
  const CourseRecommend({super.key});

  @override
  _CourseRecommendState createState() => _CourseRecommendState();
}

class _CourseRecommendState extends State<CourseRecommend> {
  Color textColor = const Color.fromRGBO(45, 67, 77, 1);
  bool isGptLoadingVisible = false; // 로딩 페이지 표시 여부를 제어하기 위한 변수

  Future<void> loadMyLecturePage() async {
    setState(() {
      isGptLoadingVisible = true; // 로딩 페이지 표시
    });

    // 2초 동안 GptLoading 페이지를 표시
    await Future.delayed(Duration(seconds: 3));

    // MyLecture 화면으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyLecture()),
    );
  }
  final ApiService apiService = ApiService(); //api 연결

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              child: SvgPicture.asset('assets/TopTheme.svg'),
            ),
            Positioned(
              top: 250,
              child: GestureDetector(
                onTap: loadMyLecturePage,
                child: SvgPicture.asset('assets/MyLecturePushButton.svg'),
              ),
            ),
            
            Positioned(
              bottom: 150,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OtherLecture()),
                  );
                },
                child: SvgPicture.asset('assets/OtherLecturePushButton.svg'),
              ),
            ),
            if (isGptLoadingVisible) // 로딩 페이지가 표시될 때만 아래 위젯 표시
              Positioned.fill(
                child: GptLoading(),
              ),
          ],
        ),
      ),
    );
  }
}

class GptLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset('assets/GptLoading.svg'), // SVG 이미지
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(194, 183, 236, 255)),
        ), // 원형 로딩 모션
      ],
    );
  }
}


//MyLecture
class MyLecture extends StatelessWidget {
  const MyLecture({super.key});

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService(); //api 연결

    Color textColor = const Color.fromRGBO(45, 67, 77, 1);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0, // 상단 위치 조절
              child: SvgPicture.asset('assets/TopTheme.svg'),
            ),
            Positioned(
              top: 70,
              left: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyButtomNaVBar()),
                  );
                },
                child: SvgPicture.asset('assets/BackButton.svg'),
              ),
            ),
            Positioned(
              top: 110, // 상단 위치 조절
              child: SvgPicture.asset('assets/TopQjBar.svg'),
            ),
            Positioned(
              top: 200, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseName.svg'),
            ),
            Positioned(
              top: 285, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseInfo.svg'),
            ),
            Positioned(
              top: 450, // 상단 위치 조절
              child: SvgPicture.asset('assets/QjLogoBack.svg'),
            ),
          ],
        ),
      ),
    );    
  }
}


//OtherLecture
class OtherLecture extends StatelessWidget {
  const OtherLecture({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color.fromRGBO(45, 67, 77, 1);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0, // 상단 위치 조절
              child: SvgPicture.asset('assets/TopTheme.svg'),
            ),
            Positioned(
              top: 70,
              left: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 이전 페이지로 돌아가기
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/BackButton.svg'),
              ),
            ),
            Positioned(
              top: 110, // 상단 위치 조절
              child: SvgPicture.asset('assets/TopQjBar.svg'),
            ),
            Positioned(
              top: 200, // 상단 위치 조절
              child: SvgPicture.asset('assets/OtherLectureBar.svg'),
            ),
            Positioned(
              top: 285, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseInfo.svg'),
            ),
            Positioned(
              top: 450, // 상단 위치 조절
              child: SvgPicture.asset('assets/QjLogoBack.svg'),
            ),
          ],
        ),
      ),
    );    
  }
}