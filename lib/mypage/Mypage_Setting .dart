import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_inner_shadow/flutter_inner_shadow.dart';
//import 'package:qj_projec/button/x_button.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  // 콜백함수
  void _navigateToService(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ServiceView()),
    );
  }

  void _navigateToInformarion(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const InformationFrom()),
    );
  }

  void _navigateToPrivacy(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PrivacyPolicy()),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/BackButton.svg'), // 뒤로가기 버튼 SVG 파일
          onPressed: () {
            Navigator.of(context).pop(); // 현재 화면을 스택에서 제거하여 이전 화면으로 돌아감
          },
        ),
        title: const Text('환경설정',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0))),
        centerTitle: true, // 제목을 가운데 정렬
        backgroundColor: Colors.white, // AppBar의 배경색을 흰색으로 설정
        elevation: 0, // AppBar의 그림자 제거
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(16, 50, 16, 50), // 상하 패딩 추가
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
                    children: [
                      Text('애플리케이션 정보',
                          style:
                              TextStyle(fontSize: 15, fontFamily: 'Poppins')),
                      SizedBox(height: 8), // 제목과 버전 사이의 간격 조정
                      Text('Version 1.0.0',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              _Line(),
              ListTile(
                title: const Text('서비스 이용약관',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                onTap: () => _navigateToService(context), // 여기에 메서드 연결
              ),
              _Line(),
              ListTile(
                title: const Text('정보 제공처',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                onTap: () => _navigateToInformarion(context),
              ),
              _Line(),
              ListTile(
                title: const Text('개인정보 처리방침',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 15)),
                onTap: () => _navigateToPrivacy(context),
              ),
              _Line(),
              // 이하 다른 설정 항목들...
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0, // 위치를 조정하여 적절한 위치를 찾습니다.
            child: SvgPicture.asset(
              'assets/RoundL.svg', // 첫 번째 원형 SVG 파일
              width: 150, // 적절한 크기로 조절
              height: 150, // 적절한 크기로 조절
            ),
          ),
          Positioned(
            bottom: 110,
            right: 90, // 위치를 조정하여 적절한 위치를 찾습니다.
            child: SvgPicture.asset(
              'assets/MypagePlane.svg', // 두 번째 원형 SVG 파일
              width: 60, // 적절한 크기로 조절
              height: 50, // 적절한 크기로 조절
            ),
          ),
          Positioned(
            bottom: 30,
            right: 0, // 위치를 조정하여 적절한 위치를 찾습니다.
            child: SvgPicture.asset(
              'assets/RoundRT.svg', // 두 번째 원형 SVG 파일
              width: 150, // 적절한 크기로 조절
              height: 150, // 적절한 크기로 조절
            ),
          ),
          Positioned(
            bottom: 0,
            right: 20, // 위치를 조정하여 적절한 위치를 찾습니다.
            child: SvgPicture.asset(
              'assets/RoundRB.svg', // 세 번째 원형 SVG 파일
              width: 130, // 적절한 크기로 조절
              height: 130, // 적절한 크기로 조절
            ),
          ),
        ],
      ),
    );
  }

  Widget _Line() {
    return const Divider(
      color: Color.fromRGBO(194, 233, 251, 100),
      thickness: 1,
      height: 1,
    );
  }
}

class ServiceView extends StatelessWidget {
  const ServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 650,
          width: 500,
          child: InnerShadow(
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(2, 5),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(37),
                  topRight: Radius.circular(37),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(2, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        '서비스 이용약관',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset('assets/XButton.svg',
                            width: 24, height: 24),
                      ),
                    ),
                  ),
                  //...
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InformationFrom extends StatelessWidget {
  const InformationFrom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 650,
          width: 500,
          child: InnerShadow(
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(2, 5),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(37),
                  topRight: Radius.circular(37),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(2, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        '정보 제공처',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset('assets/XButton.svg',
                            width: 24, height: 24),
                      ),
                    ),
                  ),
                  //...
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 650,
          width: 500,
          child: InnerShadow(
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 10,
                offset: const Offset(2, 5),
              ),
            ],
            child: Container(
              padding: const EdgeInsets.only(top: 20.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(37),
                  topRight: Radius.circular(37),
                ),
                color: const Color.fromARGB(255, 255, 255, 255),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(2, 5),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        '개인정보 처리방침',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: SvgPicture.asset('assets/XButton.svg',
                            width: 24, height: 24),
                      ),
                    ),
                  ),
                  //...
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
