import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qj_projec/mypage.dart';
import 'package:qj_projec/httpApi/api_jobDic.dart';



class JobDictionary extends StatefulWidget {
  const JobDictionary({super.key});

  @override
  State<JobDictionary> createState() => _JobDictionaryState();
}

class _JobDictionaryState extends State<JobDictionary> {
  final TextEditingController _searchController = TextEditingController();
  Color textColor = const Color.fromRGBO(161, 196, 253, 0.94);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 80,
              right: 20,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Mypage()), //Mypage => 관심직무 목록으로 변경
                  );
                },
                child: SvgPicture.asset('assets/bookmark.svg'),
              ),
            ),
            Positioned(
              top: 390,
              left: 0,
              child: SvgPicture.asset('assets/CourseRecO1.svg'),
            ),
            Positioned(
              top: 290,
              left: 130,
              child: SvgPicture.asset('assets/miniQJ.svg'),
            ),
            Positioned(
              top: 280,
              left: 170,
              child: Text(
                "진로 사전",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            Positioned(
              top: 340,
              left: 30,
              right: 30,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _searchController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: '이곳에 키워드를 검색해보세요!',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey),
                      onPressed: () => _searchController.clear(),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
                    ),
                  ),
                  onChanged: (value) {
                    // 검색어 변경 시 동작할 로직 추가
                  },
                ),
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
              left: 0,
              child: SvgPicture.asset('assets/smallQj.svg'),
            ),
            Positioned(
              top: 110,
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
              top: 230,
              left: 25,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/BackButton.svg'),
              ),
            ),
            Positioned(
              top: 230,
              right: 25,
              child: InkWell(
                onTap: () {
                  // 마이페이지 관심직무에 추가되도록 설정
                },
                child: SvgPicture.asset('assets/AddButton.svg'),
              ),
            ),
            Positioned(
              top: 295,
              child: SvgPicture.asset('assets/CourseInfo.svg'),
            ),
          ],
        ),
      ),
    );
  }
}