import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
  void _navigateToSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SettingPage()),
    );
  }

  void _navigateToProfile(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ProfileEditPage()),
    );
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
            height: 120,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Positioned(
                  left: 60,
                  bottom: 0,
                  child: SvgPicture.asset(
                    'assets/MypageProfileRound.svg',
                    width: 91.0,
                    height: 91.0,
                  ),
                ),
                Positioned(
                  left: 40,
                  bottom: 10,
                  child: Container(
                    width: 91,
                    height: 91,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/profile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20, // 왼쪽 여백 조절
                  top: 50, // 아래쪽 여백 조절
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '나의 관심직무를 설정해주세요!',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(101, 0, 0, 0),
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
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 65),
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
      title: Text(title.trim(),
          style: TextStyle(color: Colors.black, fontSize: 12)),
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}
