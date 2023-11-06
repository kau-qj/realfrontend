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

                  // 각 아이템에서 'title', 'comment', 'score'만 추출
                  List<Map<String, dynamic>> extractedData = result.map((item) {
                    return {
                      'title': item['title'],
                      'comment': item['comment'],
                      'score': item['score'],
                    };
                  }).toList();

                  // ListView.builder를 이용하여 모든 아이템을 출력
                  return ListView.builder(
                    itemCount: extractedData.length,
                    itemBuilder: (context, index) {
                      if (index == 0) { // 첫 번째 아이템인 경우
                        return Container(
                          padding: EdgeInsets.all(14.0),
                          child: ListTile(
                            title: Text('Title: ${extractedData[index]['title']}'),
                            subtitle: Text('${extractedData[index]['comment']}'),
                            trailing: Text('Score: ${extractedData[index]['score']}'),
                          ),
                        );
                      } else { // 그 외의 경우
                        return Container(
                          padding: EdgeInsets.all(14.0),
                          child: ListTile(
                            subtitle: Text('${extractedData[index]['comment']}'),
                            trailing: Text('Score: ${extractedData[index]['score']}'),
                          ),
                        );
                      }

                    },
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