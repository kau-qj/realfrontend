import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../httpApi/api_Mypage/api_mypage.dart';
import 'Mypage_Setting .dart';
import 'Mypage_profile.dart';
import 'Mypage_PrivacyPage.dart';
import 'Mypage_storage.dart';
import 'package:qj_projec/jobDic/job_details.dart';


class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String userName = ""; // 사용자 이름을 저장할 변수
  String? jobName = ""; // 사용자 직무를 저장할 변수
  String? imageUrl = ""; // 프로필 이미지 URL을 저장할 변수,  null을 허용하도록 변경
  final ApiService apiService = ApiService(); // ApiService 인스턴스를 생성합니다.

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      // Initialize ApiService with the shared cookieJar
      final ApiService _apiService = ApiService();

      // Now when you call fetchUserInfo, it will use the cookies
      final userInfo = await _apiService.fetchUserInfo();
      print('qwe: $userInfo');
      setState(() {
        userName = userInfo['userName'] ?? '';
        jobName = userInfo['jobName'];
        imageUrl = userInfo['imageUrl'] ?? '';
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
  void _navigateToJobDetails(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => JobDetails(jobname: jobName ?? ''),  // 현재 jobName을 JobDetails에 전달
      ),
    );

  if (result != null) {
    setState(() {
      jobName = result['jobName'] ?? jobName;
    });
  }
}


  void _navigateToSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SettingPage()),
    );
  }

  void _navigateToProfile(BuildContext context) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ProfileEditPage(),
      ),
    );


    if (result != null) {
      setState(() {
        jobName = result['jobName'] ?? jobName;
        imageUrl = result['imageUrl'].isEmpty
            ? 'assets/profile.png'
            : result['imageUrl'];
      });
    }
  }

  void _navigateToPrivacy() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PrivacyPage()),
    );
  }

  void _navigateToStorage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const Storage()),
    );
  }

  void _navigateToProfilImage(BuildContext context) async {
    final newProfile = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ProfileEditPage()),
    );

    if (newProfile != null) {
      setState(() {
        imageUrl = newProfile['imageUrl'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
        toolbarHeight: 120,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset('assets/QJLog.svg'),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SvgPicture.asset('assets/HompageTopBar.svg'),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            height: 130,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  left: 60,
                  top: 39,
                  child: SvgPicture.asset(
                    'assets/MypageProfileRound.svg',
                    width: 91.0,
                    height: 91.0,
                  ),
                ),
                Positioned(
                  left: 40,
                  top: 30,
                  child: Container(
                    width: 91,
                    height: 91,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: (imageUrl != null && imageUrl!.isNotEmpty)
                            ? NetworkImage(imageUrl!) as ImageProvider
                            : AssetImage('assets/profile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 40,
                  top: 0,
                  child: Text(
                    '$userName님 안녕하세요!',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
                Positioned(
                  right: 10, // 왼쪽 여백 조절
                  top: 30, // 텍스트를 원하는 위치에 배치하기 위해 조정
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        jobName != null && jobName!.isNotEmpty
                            ? '나의 관심 직무는 $jobName!'
                            : '나의 관심직무를 설정해주세요!',
                        style: TextStyle(
                          fontSize: 12,
                          color: jobName != null && jobName!.isNotEmpty
                              ? Colors.black
                              : Color.fromARGB(101, 0, 0, 0),
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _navigateToProfile(context),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/MypageEditButton.svg',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 120, // SVG가 놓일 정확한 위치를 조정하세요
                  child: SvgPicture.asset(
                    'assets/Mypagebar2.svg', // 여기에 새 SVG 파일명을 넣으세요
                    // 화면 너비에 맞게 조정할 수 있습니다
                    // height: 20, // 필요하다면 높이도 조정하세요
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              color: Colors.transparent, // 배경색을 투명으로 설정
              child: Column(
                children: [
                  _buildMenuItem('유료 구독하기', () {
                    // 다른 페이지로 이동하는 로직
                  }),
                  _Line(),
                  _buildMenuItem('QJ 보관함', _navigateToStorage),
                  _Line(),
                  _buildMenuItem('개인정보', _navigateToPrivacy),
                  _Line(),
                  _buildMenuItem(
                    '환경설정',
                    _navigateToSettings,
                  ), // 여기서 SettingPage로 이동합니다.
                  _Line(),
                  _buildMenuItem('로그아웃', () {
                    // 다른 페이지로 이동하는 로직
                  }),
                  SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _Line() {
    return Divider(
      color: Color.fromRGBO(194, 233, 251, 100),
      thickness: 1,
      height: 1,
    );
  }

  Widget _buildMenuItem(String title, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title.trim(),
        style: TextStyle(color: Colors.black, fontSize: 12),
      ),
      onTap: () {
        if (title == '나의 관심직무를 설정해주세요!') {
          _navigateToJobDetails(context);
        } else {
          onTap();
        }
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}