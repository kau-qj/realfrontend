import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QJStorage extends StatefulWidget {
  const QJStorage({Key? key}) : super(key: key);

  @override
  _QJStorageState createState() => _QJStorageState();
}

class _QJStorageState extends State<QJStorage> {
  @override
  Widget build(BuildContext context) {
    // 화면 크기를 가져옵니다.
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
              margin:
                  const EdgeInsets.only(top: 0, right: 10), // 아이콘을 조금 아래로 내립니다.
              child: SvgPicture.asset('assets/RoundTop.svg'),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 150,
        elevation: 0,
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: screenSize.height * 0.05, // 상단 위치 조정 (화면 높이의 5%)
              child: SvgPicture.asset('assets/CourseName.svg'),
            ),
            Positioned(
              top: screenSize.height * 0.15, // 상단 위치 조정 (화면 높이의 20%)
              child: SvgPicture.asset('assets/CourseInfo.svg'),
            ),
            Positioned(
              top: screenSize.height * 0.4, // 상단 위치 조정 (화면 높이의 50%)
              child: SvgPicture.asset('assets/QjLogoBack.svg'),
            ),
            // 다른 위젯들...
          ],
        ),
      ),
    );
  }
}