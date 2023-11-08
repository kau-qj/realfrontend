import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:qj_projec/bottomNav.dart';

Future<String> loginUser(String userId, String userPw, BuildContext context) async {
  // 사용자 ID와 비밀번호를 검증하는 로직을 여기에 작성합니다.
  if (userId == 'admin' && userPw == 'password') {
    // 로그인이 성공했을 경우
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyButtomNaVBar()),  // HomeDart 페이지로 이동
    );
    return '로그인 성공';
  } else {
    // 로그인이 실패했을 경우
    return '로그인 실패';
  }
}
/*
 catch (e) {
    print('loginUser 함수에서 에러 발생: $e');
    return '로그인 중 에러 발생';
  }
*/

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true; // 비밀번호 표시/숨김 상태를 저장하는 변수
  Color primaryColor = Color.fromRGBO(161, 196, 253, 1);

  // 비밀번호 표시/숨김 상태를 토글하는 함수
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0),  // 상단 패딩을 제거합니다.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                labelStyle: TextStyle(fontSize: 18),
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.lock, color: primaryColor),
                suffixIcon: IconButton(
                  icon: Icon(
                    // 비밀번호가 보이면 'visibility' 아이콘을, 아니면 'visibility_off' 아이콘을 보여줍니다.
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: primaryColor,
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ),
              obscureText: _obscureText,
            ),
            const SizedBox(height: 16.0),
            InkWell(
              onTap: () async {
                String email = _emailController.text;
                String password = _passwordController.text;
                String result = await loginUser(email, password, context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('로그인 결과'),
                    content: Text(result),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('확인'),
                      ),
                    ],
                  ),
                );
              },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,  // 그라데이션 시작점을 왼쪽 중앙으로 설정
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromRGBO(194, 233, 251, 1),  // 그라데이션 시작 색상
                        Color.fromRGBO(161, 196, 253, 0.94),  // 그라데이션 끝 색상
                      ],
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    alignment: Alignment.center,
                    child: const Text('로그인', style: TextStyle(fontSize: 23, color: Colors.white,)),
                  ),
                ),
              ),

            const SizedBox(height: 16.0),
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