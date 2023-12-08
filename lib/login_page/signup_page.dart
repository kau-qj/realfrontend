import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// 사용자 등록을 처리하는 비동기 함수 정의
Future<String> User(
    String userId,
    String userPw,
    String grade,
    String major,
    String phoneNum,
    String school,
    String jobName,
    String userName,
    String nickName) async {
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
        'phoneNum': phoneNum,
        'school': school,
        'jobName': jobName,
        'userName': userName,
        'nickName': nickName,
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
  String _grade = '1';
  TextEditingController _jobNameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nickNameController = TextEditingController();
  Color primaryColor = Color.fromRGBO(161, 196, 253, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 45.0, right: 45.0, bottom: 20),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _schoolController,
              decoration: InputDecoration(
                labelText: '학교',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 0.94)),  // 여기에서 RGB 값을 지정합니다.
                ),
                prefixIcon: Icon(Icons.school, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _majorController,
              decoration: InputDecoration(
                labelText: '전공',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 0.94)),  // 여기에서 RGB 값을 지정합니다.
                ),
                prefixIcon: Icon(Icons.book, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _grade,
              items: <String>['1', '2', '3', '4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _grade = newValue!;
                });
              },
              decoration: InputDecoration(
                labelText: '학년',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 0.94)),  // 여기에서 RGB 값을 지정합니다.
                ),
                prefixIcon: Icon(Icons.school, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _jobNameController,
              decoration: InputDecoration(
                labelText: '관심직무',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 0.94)),  // 여기에서 RGB 값을 지정합니다.
                ),
                prefixIcon: Icon(Icons.workspace_premium, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _userNameController,
              decoration: InputDecoration(
                labelText: '이름',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 0.94)),  // 여기에서 RGB 값을 지정합니다.
                ),
                prefixIcon: Icon(Icons.person, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _phoneNumController,
              decoration: InputDecoration(
                labelText: '연락처',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 0.94)),  // 여기에서 RGB 값을 지정합니다.
                ),
                prefixIcon: Icon(Icons.phone, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _nickNameController,
              decoration: InputDecoration(
                labelText: '닉네임',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 0.94)),  // 여기에서 RGB 값을 지정합니다.
                ),
                prefixIcon: Icon(Icons.person_pin, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(
                labelText: '아이디',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 0.94)),  // 여기에서 RGB 값을 지정합니다.
                ),
                prefixIcon: Icon(Icons.perm_identity, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                border: UnderlineInputBorder(),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 0.94)),  // 여기에서 RGB 값을 지정합니다.
                ),
                prefixIcon: Icon(Icons.lock, color: primaryColor),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String school = _schoolController.text;
                String major = _majorController.text;
                String grade = _grade;
                String jobName = _jobNameController.text;
                String userName = _userNameController.text;
                String phoneNum = _phoneNumController.text;
                String userId = _userIdController.text;
                String userPw = _passwordController.text;
                String nickName = _nickNameController.text;

                if (school.isEmpty ||
                    major.isEmpty ||
                    grade.isEmpty ||
                    jobName.isEmpty ||
                    userName.isEmpty ||
                    phoneNum.isEmpty ||
                    userId.isEmpty ||
                    userPw.isEmpty ||
                    nickName.isEmpty) {
                  _showAlertDialog('입력 오류', '모든 정보를 입력해주세요.');
                  return;
                }

                String result = await User(
                  userId,
                  userPw,
                  grade,
                  major,
                  phoneNum,
                  school,
                  jobName,
                  userName,
                  nickName,
                );

                if (result == '회원가입 성공') {
                  print('회원가입 정보: ');
                  print('학교: $school');
                  print('전공: $major');
                  print('학년: $grade');
                  print('관심직무: $jobName');
                  print('이름: $userName');
                  print('연락처: $phoneNum');
                  print('닉네임: $nickName');
                  print('아이디: $userId');
                  print('비밀번호: $userPw');

                  Navigator.pushReplacementNamed(context, '/login');
                }

                print(result);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(194, 233, 251, 1),
                      Color.fromRGBO(161, 196, 253, 0.94),
                    ],
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    '회원가입',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 0.0),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('이미 회원이신가요?', style: TextStyle(fontSize: 15)),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text(
                      '로그인',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: TextButton.styleFrom(
                      primary: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
