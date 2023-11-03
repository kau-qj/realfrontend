import 'package:flutter/material.dart';
import 'package:qj_projec/job_dic.dart';
import 'package:qj_projec/home.dart';
import 'package:qj_projec/mypage.dart';
import 'package:qj_projec/qjGpt_main.dart';
import 'package:qj_projec/post.dart';

import 'package:flutter_svg/flutter_svg.dart';

class MyButtomNaVBar extends StatefulWidget {
  const MyButtomNaVBar({super.key});

  @override
  State<MyButtomNaVBar> createState() => _MyButtomNavBarState();
}

class _MyButtomNavBarState extends State<MyButtomNaVBar> {
  int myCurrentIndex = 0;
  List pages = const[
    MyHompage(),
    JobDictionary(),
    CourseRecommend(),
    PostPage(),
    Mypage(),
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
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: Color.fromRGBO(178, 214, 252, 1),
              unselectedItemColor: Color.fromRGBO(178, 214, 252, 1),
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