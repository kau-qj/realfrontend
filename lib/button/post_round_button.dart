import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignRoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String svgAsset;

  const SignRoundButton(
      {Key? key, required this.onPressed, required this.svgAsset})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent, // 버튼 색상
        padding: const EdgeInsets.all(0), // 내부 패딩 제거
        elevation: 0, // 그림자 제거
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Stack(
        // Stack 위젯 사용
        alignment: Alignment.center, // 내부 아이템들을 중앙에 배치
        children: [
          SvgPicture.asset(svgAsset), // SVG 파일 로드
          const Text(
            // 텍스트 추가
            '작성완료',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold, // 글자 두께
              fontSize: 22,
              fontFamily: 'Poppins',
            ),
          ),
        ],
      ),
    );
  }
}
