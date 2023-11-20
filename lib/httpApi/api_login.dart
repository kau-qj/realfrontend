import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;
  Color primaryColor = Color.fromRGBO(161, 196, 253, 1);

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  // 비동기 함수를 사용하여 사용자 로그인 처리
  Future<void> loginUser(String userId, String userPw, BuildContext context) async {
    try {
      if (userId.isEmpty || userPw.isEmpty) {
        _showAlertDialog('입력 오류', '아이디와 비밀번호를 입력하세요.');
        return;
      }

      final baseUrl = "https://kauqj.shop";
      final endpoint = "/app/login";

      final response = await http.post(
        Uri.parse(baseUrl + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': userId,
          'userPw': userPw,
        }),
      );

      if (response.statusCode == 200) {
        // 로그인이 성공했을 때 서버에서 전송한 Set-Cookie 헤더 확인
        String setCookieHeader = response.headers['set-cookie'] ?? '';

        // 쿠키를 저장
        http.Client client = http.Client();
        client.get(Uri.parse(baseUrl), headers: {'cookie': setCookieHeader});

        // 토큰 저장
        await saveTokenToSharedPreferences(setCookieHeader);

        // 홈 화면으로 이동
        Navigator.pushReplacementNamed(context, '/home');

        // 로그인 성공 알림
        _showAlertDialog('로그인 성공', '로그인이 성공적으로 완료되었습니다.');
      } else {
        _showAlertDialog('로그인 실패', '아이디 또는 비밀번호가 올바르지 않습니다.');
      }
    } catch (e) {
      print('loginUser 함수에서 에러 발생: $e');
      _showAlertDialog('에러', '로그인 중 에러 발생');
    }
  }

  // 토큰을 SharedPreferences에 저장하는 함수
  Future<void> saveTokenToSharedPreferences(String setCookieHeader) async {
    String token = _extractTokenFromSetCookieHeader(setCookieHeader);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  // Set-Cookie 헤더에서 토큰 추출
  String _extractTokenFromSetCookieHeader(String setCookieHeader) {
    List<String> parts = setCookieHeader.split(';');
    for (String part in parts) {
      if (part.trim().startsWith('access_token=')) {
        return part.trim().substring('access_token='.length);
      }
    }
    return '';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SVG 이미지 추가
            SvgPicture.asset(
              'assets/LoginPageCircle.svg',
              height: 250,
              width: 250,
            ),
            SvgPicture.asset(
              'assets/miniQJ.svg',
              height: 50,
              width: 50,
            ),
            SizedBox(height: 70),
            // 아이디 입력 필드
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: '아이디',
                labelStyle: TextStyle(fontSize: 18),
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.account_circle, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            // 비밀번호 입력 필드
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                labelStyle: TextStyle(fontSize: 18),
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: primaryColor),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: primaryColor,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              obscureText: _obscureText,
            ),
            const SizedBox(height: 16.0),
            // 로그인 버튼
            InkWell(
              onTap: () async {
                String email = _emailController.text;
                String password = _passwordController.text;
                await loginUser(email, password, context);
              },
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
                  child: const Text('로그인', style: TextStyle(fontSize: 23, color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // 회원가입 버튼 및 텍스트
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('New member?', style: TextStyle(fontSize: 15)),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('회원가입', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  style: TextButton.styleFrom(
                    primary: primaryColor,
                  ),
                ),
              ],
            ),
            // 추가 SVG 이미지
            SvgPicture.asset(
              'assets/LoginPageCircle2.svg',
              height: 200,
              width: 200,
            ),
          ],
        ),
      ),
    );
  }
}