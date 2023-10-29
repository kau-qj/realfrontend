import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CourseDictionary extends StatefulWidget {
  const CourseDictionary({super.key});

  //const CourseDictionary({super.key});

  @override
  State<CourseDictionary> createState() => _CourseDictionaryState();
}

class _CourseDictionaryState extends State<CourseDictionary> {
  @override
  Widget build(BuildContext context) {
    Color textColor = const Color.fromRGBO(161, 196, 253, 0.94);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 50,
              left: 0, // 상단 위치 조절
              child: SvgPicture.asset('assets/img/smallQj.svg'),
            ),
            Positioned(
              top:110,
              child: Text(
                "강의 사전",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            Positioned(
              top: 160,
              child: SvgPicture.asset('assets/img/SearchButton.svg'),
            ),
            Positioned(
              top: 250,
              left: 15,
              child: SvgPicture.asset('assets/img/DictionaryInButton.svg'),
            ),
            Positioned(
              top: 250,
              right: 15,
              child: SvgPicture.asset('assets/img/DictionaryInButton.svg'),
            ),
            Positioned(
              top: 500,
              left: 15,
              child: SvgPicture.asset('assets/img/DictionaryInButton.svg'),
            ),
            Positioned(
              top: 500,
              right: 15,
              child: SvgPicture.asset('assets/img/DictionaryInButton.svg'),
            ),
          ],
        ),
      ),
    );
  }
}