import 'package:flutter/material.dart';
import 'package:qj_projec/jobDic/job_main.dart';
import 'package:qj_projec/home.dart';
import 'package:qj_projec/mypage/myPage.dart';
import 'package:qj_projec/qjGpt/qjGpt_myjob.dart';
import 'package:qj_projec/POST/post.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyButtomNaVBar extends StatefulWidget {
  const MyButtomNaVBar({super.key});

  @override
  State<MyButtomNaVBar> createState() => _MyButtomNavBarState();
}

class _MyButtomNavBarState extends State<MyButtomNaVBar> {
  int myCurrentIndex = 0;
  List pages = const[
    MyHompage(), //홈
    JobDictionary(), //진로사전
    CourseRecommend(), //강의추천
    PostPage(), //게시판
    MyPage(), //마이페이지
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar:Container(
          margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0), 
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 30,
                offset: const Offset(0,15))
            ]),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Color.fromRGBO(161, 196, 253, 1),
              unselectedItemColor: Color.fromRGBO(161, 196, 253, 1),
              onTap: (index){
                setState(() {
                  myCurrentIndex = index;
                });
              },
              currentIndex: myCurrentIndex,
              showUnselectedLabels: true,
              showSelectedLabels: true,
              items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),label: "홈"
                    ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.import_contacts),label: "진로사전"),
                  BottomNavigationBarItem(
                    icon: SizedBox(
                      height: 24,
                      width: 24,
                      child: SvgPicture.asset('assets/miniQJ.svg'),
                    ),
                    label: "강의추천",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.article),label: "게시판"),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),label: "마이페이지"),
                  ]),
          ),
          ),
      body: pages[myCurrentIndex],
    );
  }
}