import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HompageAdButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String svgAsset;

  const HompageAdButton(
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
      ),
      child: SvgPicture.asset(svgAsset), // SVG 파일 로드
    );
  }
}
