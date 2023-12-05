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
              top: screenSize.height * 0.1,
              left: screenSize.width * 0.05,
              child: InkWell(
                onTap: () {
                  // 이전 페이지로 돌아가기
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    SvgPicture.asset('assets/BackButton.svg'),
                    SizedBox(
                        width: screenSize.width * 0.05), // SVG 이미지와 텍스트 사이의 간격
                    Text('QJ 보관함',
                        style: TextStyle(
                            fontSize: screenSize.width * 0.06)) // 텍스트 추가
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0, // 상단 위치 조절
              child: SvgPicture.asset('assets/RoundTop.svg'),
            ),
            Positioned(
              top: screenSize.height * 0.2, // 상단 위치 조절
              child: Stack(
                children: [
                  SvgPicture.asset('assets/CourseName.svg'),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: screenSize.height * 0.03,
                        child: FutureBuilder<List<dynamic>>(
                          future: courseDetails,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData &&
                                snapshot.data!.isNotEmpty) {
                              var course =
                                  snapshot.data![0]; // 첫 번째 코스 세부정보를 가져옵니다.
                              return Text(
                                course['title'],
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.05, // 글자 크기
                                  fontWeight: FontWeight.bold, // 글자 두께
                                ),
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return const Text('QJ를 통해 관심직무를 검색해보세요!');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: screenSize.height * 0.3, // 상단 위치 조절
              child: SvgPicture.asset(
                'assets/CourseInfo.svg',
                height: screenSize.height * 0.68, // 원하는 높이로 조절
              ),
            ),
            Positioned(
              top: screenSize.height * 0.52, // 상단 위치 조절
              child: SvgPicture.asset(
                'assets/QjLogoBack.svg',
                width: screenSize.width * 0.4, // 원하는 너비로 조절
                height: screenSize.width * 0.4, // 원하는 높이로 조절
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
                  return Positioned(
                    top: screenSize.height * 0.31,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: screenSize.height - screenSize.height * 0.35,
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenSize.width * 0.05), // 패딩 값 지정
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: (course['details'] as List<dynamic>)
                                  .map<Widget>((item) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      screenSize.width * 0.045,
                                      screenSize.height * 0.01,
                                      screenSize.width * 0.045,
                                      screenSize.height * 0.01),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.zero,
                                    leading: Text(
                                      'Score: ${item['score']}',
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.04,
                                      ),
                                    ),
                                    title: Text(
                                      item['comment'],
                                      style: TextStyle(
                                        fontSize: screenSize.width * 0.035,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
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