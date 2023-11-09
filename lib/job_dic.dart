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
    Color textColor = const Color.fromRGBO(161, 196, 253, 0.94);
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
                  color: textColor,
                ),
              ),
            ),
            Positioned(
              top: 160,
              child: SvgPicture.asset('assets/SearchButton.svg'),
            ),
            Positioned(
              top: 250,
              left: 15,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const jobEx1()),
                  );
                },
                child: SvgPicture.asset('assets/DictionaryInButton.svg'),
              ),
            ),
            Positioned(
              top: 250,
              right: 15,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const jobEx2()),
                  );
                },
                child: SvgPicture.asset('assets/DictionaryInButton.svg'),
              ),
            ),
            Positioned(
              top: 500,
              left: 15,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const jobEx3()),
                  );
                },
                child: SvgPicture.asset('assets/DictionaryInButton.svg'),
              ),
            ),
            Positioned(
              top: 500,
              right: 15,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const jobEx4()),
                  );
                },
                child: SvgPicture.asset('assets/DictionaryInButton.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class jobEx1 extends StatelessWidget {
  const jobEx1({super.key});
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
              child: SvgPicture.asset('assets/smallQj.svg'),
            ),
            Positioned(
              top:110,
              child: Text(
                "진로 사전",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            Positioned(
              top: 160,
              child: SvgPicture.asset('assets/SearchButton.svg'),
            ),
            Positioned(
              top: 230,
              left: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 이전 페이지로 돌아가기
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/BackButton.svg'),
              ),
            ),
            Positioned(
              top: 230,
              right: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 마이페이지 관심직무에 추가되도록 설정
                },
                child: SvgPicture.asset('assets/AddButton.svg'),
              ),
            ),
            Positioned(
              top: 295, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseInfo.svg'),
            ),
          ],
        ),
      ),
    );    
  }
}

class jobEx2 extends StatelessWidget {
  const jobEx2({super.key});
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
              child: SvgPicture.asset('assets/smallQj.svg'),
            ),
            Positioned(
              top:110,
              child: Text(
                "진로 사전",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            Positioned(
              top: 160,
              child: SvgPicture.asset('assets/SearchButton.svg'),
            ),
            Positioned(
              top: 230,
              left: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 이전 페이지로 돌아가기
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/BackButton.svg'),
              ),
            ),
            Positioned(
              top: 230,
              right: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 마이페이지 관심직무에 추가되도록 설정
                },
                child: SvgPicture.asset('assets/AddButton.svg'),
              ),
            ),
            Positioned(
              top: 295, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseInfo.svg'),
            ),
          ],
        ),
      ),
    );    
  }
}

class jobEx3 extends StatelessWidget {
  const jobEx3({super.key});
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
              child: SvgPicture.asset('assets/smallQj.svg'),
            ),
            Positioned(
              top:110,
              child: Text(
                "진로 사전",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            Positioned(
              top: 160,
              child: SvgPicture.asset('assets/SearchButton.svg'),
            ),
            Positioned(
              top: 230,
              left: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 이전 페이지로 돌아가기
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/BackButton.svg'),
              ),
            ),
            Positioned(
              top: 230,
              right: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 마이페이지 관심직무에 추가되도록 설정
                },
                child: SvgPicture.asset('assets/AddButton.svg'),
              ),
            ),
            Positioned(
              top: 295, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseInfo.svg'),
            ),
          ],
        ),
      ),
    );    
  }
}

class jobEx4 extends StatelessWidget {
  const jobEx4({super.key});
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
              child: SvgPicture.asset('assets/smallQj.svg'),
            ),
            Positioned(
              top:110,
              child: Text(
                "진로 사전",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            Positioned(
              top: 160,
              child: SvgPicture.asset('assets/SearchButton.svg'),
            ),
            Positioned(
              top: 230,
              left: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 이전 페이지로 돌아가기
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/BackButton.svg'),
              ),
            ),
            Positioned(
              top: 230,
              right: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 마이페이지 관심직무에 추가되도록 설정
                },
                child: SvgPicture.asset('assets/AddButton.svg'),
              ),
            ),
            Positioned(
              top: 295, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseInfo.svg'),
            ),
          ],
        ),
      ),
    );    
  }
}