import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qj_projec/httpApi/api_Mypage/api_Mypage_QJStorage.dart';

class QJStorage extends StatefulWidget {
  final int setIdx;

  const QJStorage({Key? key, required this.setIdx}) : super(key: key);

  @override
  _QJStorageState createState() => _QJStorageState();
}

class _QJStorageState extends State<QJStorage> {
  late Future<List<dynamic>> courseDetails;

  @override
  void initState() {
    super.initState();
    courseDetails = ApiService().fetchCourseDetails(widget.setIdx);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 70,
              left: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 이전 페이지로 돌아가기
                  Navigator.pop(context);
                },
              child: Row(
                children: [
                  SvgPicture.asset('assets/BackButton.svg'),
                  SizedBox(width: 20),  // SVG 이미지와 텍스트 사이의 간격
                  Text('QJ 보관함', style: TextStyle(fontSize: 23))  // 텍스트 추가
                ],
              ),
              ),
            ),
            Positioned(
              top: 50,
              right: 0, // 상단 위치 조절
              child: SvgPicture.asset('assets/RoundTop.svg'),
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
            FutureBuilder<List<dynamic>>(
              future: courseDetails,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  var course = snapshot.data![0]; // 첫 번째 코스 세부정보를 가져옵니다.
                  return Stack(
                    children:[
                      Positioned(
                        top: 210, // 적절한 위치 조정
                        left: 0,
                        right: 0,
                        child: Text(course['title'],
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
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 0),
                                child: Column(
                                  children: (course['details'] as List<dynamic>).map<Widget>((item) {
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
                                      child: ListTile(
                                        leading: Text('Score: ${item['score']}'),  // leading 사용
                                        title: Text(item['comment']),  // title 사용
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
                } else {
                  return const Text('No data found');
                }
              },
            ),

          ], 
        ),
      ),
    );
  }
}
