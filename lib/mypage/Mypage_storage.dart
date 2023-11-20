import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Mypage_QJstorage.dart';

class Storage extends StatelessWidget {
  const Storage({Key? key}) : super(key: key);

  void _navigateToQjStorage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const QJStorage()),
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
                margin: const EdgeInsets.only(top: 15), // 아이콘을 조금 아래로 내립니다.
                child: SvgPicture.asset('assets/RoundTop.svg'),
              )
            ],
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          toolbarHeight: 150,
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: () => _navigateToQjStorage(context),
          child: SvgPicture.asset(
            'assets/QjStorageBox.svg',
            width: 150,
            height: 200,
          ),
        ));
  }
}
