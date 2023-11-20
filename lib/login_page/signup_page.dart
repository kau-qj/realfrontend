import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// 사용자 등록을 처리하는 비동기 함수 정의
Future<String> User(String userId, String userPw, String grade, String major, String phonenumber, String school, String jobname) async {
  try {
    // 서버의 기본 URL 및 엔드포인트 정의
    final baseUrl = "https://kauqj.shop";
    final endpoint = "/app/users";

    print("baseUrl : $baseUrl");
    print("endpoint : $endpoint");

    // 서버에 POST 요청 보내기
    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // 사용자 데이터를 JSON 형식으로 변환
      body: jsonEncode(<String, String>{
        'userId': userId,
        'userPw': userPw,
        'grade': grade,
        'major': major,
        'phonenumber': phonenumber,
        'school': school,
        'jobname': jobname
      }),
    );
    // 요청이 성공적으로 이루어졌는지 확인 (상태 코드 200)
    if (response.statusCode == 200) {
      print("good");
      return '회원가입 성공'; // 회원가입 성공
    } else {
      return '회원가입 실패'; // 회원가입 실패
    }
  } catch (e) {
    print('signupUser 함수에서 에러 발생: $e');
    return '회원가입 중 에러 발생';
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController _schoolController = TextEditingController();
  TextEditingController _majorController = TextEditingController();
  String _year = '1';
  TextEditingController _interestController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Color primaryColor = Color.fromRGBO(196, 239, 255, 0.855);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          '회원가입',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20, // 글씨 크기 조절
            color: Colors.white, // 텍스트 색상 흰색으로 변경
          ),
        ),
        // 왼쪽 상단에 뒤로가기 버튼 추가
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _schoolController,
              decoration: InputDecoration(
                labelText: '학교',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.school, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _majorController,
              decoration: InputDecoration(
                labelText: '전공',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.book, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _year,
              items: <String>['1', '2', '3', '4'].map<DropdownMenuItem<String>>((String value) {
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
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.school, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _interestController,
              decoration: InputDecoration(
                labelText: '관심직무',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.workspace_premium, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: '이름',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _contactController,
              decoration: InputDecoration(
                labelText: '연락처',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(
                labelText: '아이디',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.account_circle, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: primaryColor),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // 사용자가 입력한 정보 수집
                String school = _schoolController.text;
                String major = _majorController.text;
                String year = _year;
                String interest = _interestController.text;
                String name = _nameController.text;
                String contact = _contactController.text;
                String userId = _userIdController.text;
                String userPw = _passwordController.text;

                // 각 필드가 비어있는지 확인
                if (school.isEmpty ||
                    major.isEmpty ||
                    year.isEmpty ||
                    interest.isEmpty ||
                    name.isEmpty ||
                    contact.isEmpty ||
                    userId.isEmpty ||
                    userPw.isEmpty) {
                  _showAlertDialog('입력 오류', '모든 정보를 입력해주세요.');
                  return;
                }

                // 사용자 등록 함수 호출
                String result = await User(
                  userId,
                  userPw,
                  year,
                  major,
                  contact,
                  school,
                  interest,
                );

                if (result == '회원가입 성공') {
                  // 회원가입 정보 출력
                  print('회원가입 정보: ');
                  print('학교: $school');
                  print('전공: $major');
                  print('학년: $year');
                  print('관심직무: $interest');
                  print('이름: $name');
                  print('연락처: $contact');
                  print('아이디: $userId');
                  print('비밀번호: $userPw');

                  // 회원가입 성공 후 로그인 화면으로 이동
                  Navigator.pushReplacementNamed(context, '/login');
                }

                print(result);
              },
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                onPrimary: Colors.white, // 글씨 색상 추가
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text(
                '회원가입',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 알림 창을 띄우는 함수
  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
