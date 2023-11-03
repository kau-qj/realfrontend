import 'package:flutter/material.dart';
import 'package:qj_projec/job_dic.dart';
import 'package:qj_projec/home.dart';
import 'package:qj_projec/mypage.dart';
import 'package:qj_projec/qjGpt_main.dart';
import 'package:qj_projec/post.dart';

class MyButtomNaVBar extends StatefulWidget {
  const MyButtomNaVBar({super.key});

  @override
  State<MyButtomNaVBar> createState() => _MyButtomNavBarState();
}

class _MyButtomNavBarState extends State<MyButtomNaVBar> {
  int myCurrentIndex = 0;
  List pages = const[
    HomePage(),
    JobDictionary(),
    CourseRecommend(),
    PostPage(),
    Mypage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar:Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15), 
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 25,
                offset: const Offset(8, 20))
            ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: Color.fromRGBO(196, 239, 255, 0.855),
              unselectedItemColor: Color.fromARGB(160, 144, 202, 244),
              onTap: (index){
                setState(() {
                  myCurrentIndex = index;
                });
              },
              currentIndex: myCurrentIndex,items: const[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),label: "홈"),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.import_contacts),label: "진로사전"),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.school),label: "강의추천"),
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