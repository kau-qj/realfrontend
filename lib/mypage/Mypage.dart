import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../httpApi/api_Mypage/api_mypage.dart';
import 'Mypage_Setting .dart';
import 'Mypage_profile.dart';
import 'Mypage_PrivacyPage.dart';
import 'Mypage_storage.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String userName = ""; // 사용자 이름을 저장할 변수
  String? job = ""; // 사용자 직무를 저장할 변수
  String? imageUrl = ""; // 프로필 이미지 URL을 저장할 변수,  null을 허용하도록 변경
  final ApiService _apiService = ApiService(); // ApiService 인스턴스를 생성합니다.

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      final userInfo = await _apiService.fetchUserInfo();
      setState(() {
        userName = userInfo['userName']; //유저 이름 업데이트
        job = userInfo['job']; // 관심직무 업데이트
        imageUrl = userInfo['imageUrl'] ?? ''; //프로필 업데이트
      });
    } catch (e) {
      // 에러 처리
      print('Error fetching user data: $e');
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
        job = result['job'] ?? job;
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
                  right: 20, // 왼쪽 여백 조절
                  top: 50, // 텍스트를 원하는 위치에 배치하기 위해 조정
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job != null && job!.isNotEmpty
                            ? '나의 관심 직무는 $job!'
                            : '나의 관심직무를 설정해주세요!',
                        style: TextStyle(
                          fontSize: 12,
                          color: job != null && job!.isNotEmpty
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
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 100, // SVG가 놓일 정확한 위치를 조정하세요
                              child: SvgPicture.asset(
                                'assets/Mypagebar2.svg', // 여기에 새 SVG 파일명을 넣으세요
                                // 화면 너비에 맞게 조정할 수 있습니다
                                // height: 20, // 필요하다면 높이도 조정하세요
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
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
                    '환경설정', _navigateToSettings), // 여기서 SettingPage로 이동합니다.
                _Line(),
                _buildMenuItem('로그아웃', () {
                  // 다른 페이지로 이동하는 로직
                }),
                SizedBox(height: 5),
              ],
            ),
          ),
          Container(
            height: 150, // SVG 아이콘들의 컨테이너 높이 설정
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0, // 위치를 조정하여 적절한 위치를 찾습니다.
                  child: SvgPicture.asset(
                    'assets/RoundL.svg', // 첫 번째 원형 SVG 파일
                    width: 150, // 적절한 크기로 조절
                    height: 150, // 적절한 크기로 조절
                  ),
                ),
                Positioned(
                  bottom: 110,
                  right: 90, // 위치를 조정하여 적절한 위치를 찾습니다.
                  child: SvgPicture.asset(
                    'assets/MypagePlane.svg', // 두 번째 원형 SVG 파일
                    width: 60, // 적절한 크기로 조절
                    height: 50, // 적절한 크기로 조절
                  ),
                ),
                Positioned(
                  bottom: 30,
                  right: 0, // 위치를 조정하여 적절한 위치를 찾습니다.
                  child: SvgPicture.asset(
                    'assets/RoundRT.svg', // 두 번째 원형 SVG 파일
                    width: 150, // 적절한 크기로 조절
                    height: 150, // 적절한 크기로 조절
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 20, // 위치를 조정하여 적절한 위치를 찾습니다.
                  child: SvgPicture.asset(
                    'assets/RoundRB.svg', // 세 번째 원형 SVG 파일
                    width: 130, // 적절한 크기로 조절
                    height: 130, // 적절한 크기로 조절
                  ),
                ),
              ],
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
          _navigateToProfile(context);
        } else {
          onTap();
        }
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}
