import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../httpApi/api_Mypage/api_mypage_privacy.dart'; // 해당 부분은 실제 API 서비스 파일을 import 해야 합니다.

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  TextEditingController _schoolController = TextEditingController();
  TextEditingController _majorController = TextEditingController();
  String _year = '1'; // 기본적으로 '1'학년이 선택되도록 설정합니다.
  TextEditingController _interestController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Color primaryColor = Color.fromRGBO(161, 196, 253, 1);

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
      final ApiService _apiService = ApiService();
      final userInfo = await _apiService.fetchUserInfo();
      setState(() {
        _nameController.text = userInfo['userName'];
        _majorController.text = userInfo['major'];
        _year = userInfo['grade'].toString();
        _schoolController.text = userInfo['school'];
        _contactController.text = userInfo['phoneNum'];
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/BackButton.svg'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              '개인정보',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: SvgPicture.asset('assets/RoundTop.svg'),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 140,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Column(
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '학교정보',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color.fromARGB(255, 117, 113, 113),
                    ),
                  ),
                  SizedBox(height: 8),
                  TextField(
                    controller: _schoolController,
                    decoration: InputDecoration(
                      labelText: '학교',
                      border: UnderlineInputBorder(),
                      prefixIcon: Icon(Icons.school, color: primaryColor),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _majorController,
              decoration: InputDecoration(
                labelText: '전공',
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.book, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _year,
              items: <String>['1', '2', '3', '4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _year = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: '학년',
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.school, color: primaryColor),
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              '개인정보',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color.fromARGB(255, 117, 113, 113),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: '이름',
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.person, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: '연락처',
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.phone, color: primaryColor),
              ),
            ),
            SizedBox(height: screenSize.height * 0.04),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: SvgPicture.asset('assets/RoundButton.svg'),
        ),
      ),
    );
  }
}