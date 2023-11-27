import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../httpApi/api_Mypage/api_mypage_privacy.dart';

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
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  void _fetchUserData() async {
    try {
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

  void _savePrivacy() async {
    var uri = Uri.parse('https://kauqj.shop/mypage/info');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer YOUR_JWT_TOKEN_HERE' // Replace with your actual JWT token
    };
    var body = jsonEncode({
      'userName': _nameController.text,
      'major': _majorController.text,
      'grade': int.tryParse(_year) ??
          1, // Make sure to convert the grade to an integer
      'school': _schoolController.text,
      'phoneNum': _contactController.text
    });

    try {
      var response = await http.put(uri, headers: headers, body: body);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['isSuccess'] == true) {
        print('개인정보 업데이트 성공');
        // Perform success operations here
      } else {
        print('개인정보 업데이트 실패: ${data['message']}');
        // Handle the failure here, you can use data['message'] to understand the reason
      }
    } catch (e) {
      print('개인정보 업데이트 에러: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      '개인정보',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color.fromARGB(255, 117, 113, 113),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
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
          ),
          Container(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 30.0, top: 10.0),
            color: Color.fromARGB(255, 255, 255, 255),
            child: InkWell(
              onTap: _savePrivacy,
              child: SvgPicture.asset(
                'assets/RoundButton.svg',
                // 필요하다면 SVG의 크기를 조절하세요
              ),
            ),
          ),
        ],
      ),
    );
  }
}
