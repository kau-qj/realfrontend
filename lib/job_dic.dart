import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qj_projec/bottomNav.dart';


class JobDictionary extends StatefulWidget {
  const JobDictionary({super.key});

  //const CourseDictionary({super.key});

  @override
  State<JobDictionary> createState() => _JobDictionaryState();
}

class _JobDictionaryState extends State<JobDictionary> {
  @override
  Widget build(BuildContext context) {
    Color textColor1 = const Color.fromRGBO(161, 196, 253, 0.94);
    Color textColor2 = const Color.fromRGBO(45, 67, 77, 1);

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 50,
              left: 0, // 상단 위치 조절
              child: SvgPicture.asset('assets/smallQj.svg'),
            ),
            Positioned(
              top:110,
              child: Text(
                "진로 사전",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: textColor1,
                ),
              ),
            ),
            Positioned(
              top: 160,
              child: SvgPicture.asset('assets/SearchButton.svg'),
            ),
            Positioned(
              top: 240,
              right: 15,
              child: SvgPicture.asset('assets/AddButton.svg'),
            ),
            Positioned(
              top: 256,
              right: 60,
              child: Text(
                "관심 직무 추가하기",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: textColor2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}