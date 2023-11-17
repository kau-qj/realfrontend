import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qj_projec/qjGpt/qjGpt_myJob.dart';
import 'package:qj_projec/httpApi/api_qjGpt_newJob.dart';


class OtherLecture extends StatefulWidget {
  const OtherLecture({Key? key});

  @override
  _OtherLectureState createState() => _OtherLectureState();
}


//OtherLecture
class _OtherLectureState extends State<OtherLecture> {
  bool isGptLoadingVisible = false; // 로딩 페이지 표시 여부를 제어하기 위한 변수

  Future<void> loadMyLecturePage() async {
    setState(() {
      isGptLoadingVisible = true; // 로딩 페이지 표시
    });

    final ApiService apiService = ApiService(); //api 연결


    // 3초 동안 GptLoading 페이지를 표시
    //await Future.delayed(Duration(seconds: 3));

    // MyLecture 화면으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OtherLecture()),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color.fromRGBO(45, 67, 77, 1);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
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
              child: SvgPicture.asset('assetsß/TopQjBar.svg'),
            ),
            Positioned(
              top: 200, // 상단 위치 조절
              child: SvgPicture.asset('assets/OtherLectureBar.svg'),
            ),
            Positioned(
              top: 265, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseInfo.svg'),
            ),
            Positioned(
              top: 310, // 상단 위치 조절
              child: Text('----이곳에는 강의 정보와 점수가 나올 것입니다.----'),
            ),
            Positioned(
              bottom: 80, // 상단 위치 조절
              child: Text('---------------산학 에이플 가쟈~---------------'),
            ),
            Positioned(
              top: 450, // 상단 위치 조절
              child: SvgPicture.asset('assets/QjLogoBack.svg'),
            ),
            Positioned(
              top: 215, // 상단 위치 조절
              child: TextField(
                  decoration: InputDecoration(
                      labelText: '다른 관심 직무',
                      border: UnderlineInputBorder(),
                  ),
              ),
            ),
          ],
        ),
      ),
    );    
  }
}