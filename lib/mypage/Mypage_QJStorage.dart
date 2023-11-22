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
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/BackButton.svg'), // 뒤로가기 버튼 SVG 파일
          onPressed: () {
            Navigator.of(context).pop(); // 현재 화면을 스택에서 제거하여 이전 화면으로 돌아감
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min, // 자식들의 크기만큼 Row의 크기를 설정
          children: [
            const Text(
              'QJ 보관함',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              margin: const EdgeInsets.only(top: 0, right: 10),
              child: SvgPicture.asset('assets/RoundTop.svg'),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 150,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: courseDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            var course = snapshot.data!.first; // 첫 번째 코스 세부정보를 가져옵니다.
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                SvgPicture.asset('assets/CourseName.svg'),
                Positioned(
                  top: screenSize.height * 0.05, // 적절한 위치 조정
                  child: Text(course['title'],
                      style: TextStyle(
                          // 스타일 설정
                          )),
                ),
                SvgPicture.asset('assets/CourseInfo.svg'),
                Positioned(
                  top: screenSize.height * 0.1, // 적절한 위치 조정
                  child: Text(
                      'Score: ${course['score']} Comment: ${course['comment']}',
                      style: TextStyle(
                          // 스타일 설정
                          )),
                ),
                Positioned(
                  top: screenSize.height * 0.4, // 상단 위치 조정 (화면 높이의 50%)
                  child: SvgPicture.asset('assets/QjLogoBack.svg'),
                )
              ],
            );
          } else {
            return const Text('No data found');
          }
        },
      ),
    );
  }
}
