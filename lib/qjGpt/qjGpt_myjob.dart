import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:qj_projec/httpApi/api_qjGpt_myJob.dart';
import 'package:qj_projec/qjGpt/qjGpt_newJob.dart';
import 'package:qj_projec/mypage/Mypage_storage.dart';


class CourseRecommend extends StatefulWidget {
  const CourseRecommend({super.key});

  @override
  _CourseRecommendState createState() => _CourseRecommendState();
}

class _CourseRecommendState extends State<CourseRecommend> {
  //String? jobName = UserData().jobName;
  Color textColor = const Color.fromRGBO(45, 67, 77, 1);
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
              top: 0,
              child: SvgPicture.asset('assets/TopTheme.svg'),
            ),
            Positioned(
              top: 80,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Storage()), //Mypage => 관심직무 목록으로 변경
                  );
                },
                child: SvgPicture.asset('assets/bookmark.svg'),
              ),
            ),
            Positioned(
              top: 100,
              left: 0,
              child: SvgPicture.asset('assets/CourseRecO1.svg'),
            ),
            Positioned(
              top: 250,
              child: GestureDetector(
                onTap: loadMyLecturePage,
                child: SvgPicture.asset('assets/MyLecturePushButton.svg'),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 0,
              child: SvgPicture.asset('assets/CourseRecO2.svg'),
            ),
            Positioned(
              bottom: 180,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OtherLecture()), //Mypage => 관심직무 목록으로 변경
                  );
                },
                child: SvgPicture.asset('assets/OtherLecturePushButton.svg'),
              ),
            ),
            /*
            if (isGptLoadingVisible) // 로딩 페이지가 표시될 때만 아래 위젯 표시
              Positioned.fill(
                child: GptLoading(),
              ),
            */
          ],
        ),
      ),
    );
  }
}

class GptLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 흰색 배경
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset('assets/GptLoading.svg'), // SVG 이미지
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(194, 183, 236, 255)),
          ), // 원형 로딩 모션
        ],
      ),
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
                  // 이전 페이지로 돌아가기
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/BackButton.svg'),
              ),
            ),
            Positioned(
              top: 105, // 상단 위치 조절
              child: SvgPicture.asset('assets/TopQjBar.svg'),
            ),
            Positioned(
              top: 195, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseName.svg'),
            ),
            Positioned(
              top: 260, // 상단 위치 조절
              child: SvgPicture.asset(
                'assets/CourseInfo.svg',
                //width: 270, // 원하는 너비로 조절
                height: 650, // 원하는 높이로 조절
              ),
            ),
            Positioned(
              top: 450, // 상단 위치 조절
              child: SvgPicture.asset(
                'assets/QjLogoBack.svg',
                width: 170, // 원하는 너비로 조절
                height: 170, // 원하는 높이로 조절
              ),
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: apiService.fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return GptLoading(); // GptLoading 위젯 반환
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!['result'] == null) {
                  return Text('No data fetched from API.');
                } else {
                  // API로부터 받아온 데이터를 저장
                  List result = snapshot.data!['result'];

                  // 각 아이템에서 'title', 'comment', 'score', 'details'만 추출
                  List<Map<String, dynamic>> extractedData = result.map((item) {
                    return {
                      'title': item['title'],
                      'comment': item['comment'],
                      'score': item['score'],
                      'details': item['details'],
                    };
                  }).toList();
                  return Stack(
                    children: [
                      Positioned(
                        top: 210,
                        left: 0,
                        right: 0,
                        child: Text(
                          '${extractedData[0]['title']}',
                          style: TextStyle(
                            fontSize: 16,     // 글자 크기
                            fontWeight: FontWeight.bold,  // 글자 두께
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Positioned(
                        top: 280,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: MediaQuery.of(context).size.height - 340,
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 10),  // 패딩 값 지정
                            children: <Widget>[
                              SizedBox(height: 30),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Column(
                                  children: extractedData[0]['details'].map<Widget>((item) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
                                      child: ListTile(
                                        leading: Text('Score: ${item['score']}'),  // leading 사용
                                        subtitle: Text('${item['comment']}'),  // title 사용
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );    
  }
}