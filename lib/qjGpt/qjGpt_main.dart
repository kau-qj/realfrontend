import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';

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
    await Future.delayed(Duration(seconds: 5));

    // MyLecture 화면으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MyLecture()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 23,
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
              bottom: 250,
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
            Positioned(
              top: 288,
              child: Text(
                "내 직무 강의 추천",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            Positioned(
              bottom: 295,
              child: Text(
                "다른 직무 강의 추천",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
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
    return SvgPicture.asset('assets/GptLoading.svg');
  }
}

class MyLecture extends StatelessWidget {
  const MyLecture({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color.fromRGBO(45, 67, 77, 1);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 23, // 상단 위치 조절
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
              child: SvgPicture.asset('assets/CourseName.svg'),
            ),
            Positioned(
              top: 285, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseInfo.svg'),
            ),
            Positioned(
              top: 420, // 상단 위치 조절
              child: SvgPicture.asset('assets/QjLogoBack.svg'),
            ),
          ],
        ),
      ),
    );    
  }
}

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
              top: 23, // 상단 위치 조절
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
              top: 420, // 상단 위치 조절
              child: SvgPicture.asset('assets/QjLogoBack.svg'),
            ),
          ],
        ),
      ),
    );    
  }
}