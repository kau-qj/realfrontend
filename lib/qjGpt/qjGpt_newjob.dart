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
              top: 170, // 상단 위치 조절
              child: SvgPicture.asset(
                'assets/QJLog.svg',
                width: 200,  // 너비 조절
                height: 200,  // 높이 조절
              ),
            ),
            Positioned(
              top: 370, // 상단 위치 조절
              child: Container(
                width: MediaQuery.of(context).size.width,  // 화면 너비를 가져와서 지정
                child: SvgPicture.asset('assets/OtherLectureBar_1.svg'),
              ),
            ),
            Positioned(
              top: 370, // 'OtherLectureBar_1' SVG 이미지 위에 위치
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 70),
                child: TextField(
                  decoration: InputDecoration(
                    //border: OutlineInputBorder(),
                    labelText: '여기에 새로운 관심 직무를 써주세요',
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0, // 상단 위치 조절
              child: Container(
                width: MediaQuery.of(context).size.width,  // 화면 너비를 가져와서 지정
                child: SvgPicture.asset('assets/BottomTheme.svg'),
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
              top: 110, // 상단 위치 조절
              child: SvgPicture.asset('assets/TopQjBar.svg'),
            ),
            Positioned(
              top: 200, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseName.svg'),
            ),
            Positioned(
              top: 265, // 상단 위치 조절
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

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 211, left: 0.0, right: 0.0),  // 패딩 값 지정
                        child: Text(
                          '${extractedData[0]['title']}',
                          style: TextStyle(
                              fontSize: 15,     // 글자 크기
                              fontWeight: FontWeight.bold,  // 글자 두께
                            ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 275),
                        child: Container(
                          height: MediaQuery.of(context).size.height - 300,
                          child: ListView.builder(
                            itemCount: extractedData.length,
                            itemBuilder: (context, index) {
                              // 첫 번째 아이템에만 상단에 패딩을 적용
                              return Padding(
                                padding: index == 0 ? EdgeInsets.fromLTRB(18, 0, 18, 10) : EdgeInsets.fromLTRB(18, 5, 18, 0),
                                child: ListTile(
                                  subtitle: Text('${extractedData[index]['comment']}'),
                                  trailing: Text('Score: ${extractedData[index]['score']}'),
                                ),
                              );
                            },
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