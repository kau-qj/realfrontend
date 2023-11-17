import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> loginUser(String userId, String userPw) async {
  try {
    final baseUrl = "https://kauqj.shop";
    final endpoint = "/app/login";


    print("baseUrl : $baseUrl");
    print("endpoint : $endpoint");
    
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
      print("good");
      return '로그인 성공';
    } else {
      return '로그인 실패';
    }
  } catch (e) {
    print('loginUser 함수에서 에러 발생: $e');
    return '로그인 중 에러 발생';
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true; // 비밀번호 표시/숨김 상태를 저장하는 변수
  Color primaryColor = Color.fromRGBO(196, 239, 255, 0.855);

  // 비밀번호 표시/숨김 상태를 토글하는 함수
  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('로그인', style: TextStyle(fontSize: 20)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _idController,
              decoration: InputDecoration(
                labelText: '아이디',
                labelStyle: TextStyle(fontSize: 20),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.account_circle, color: primaryColor),
              ),
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: '비밀번호',
                labelStyle: TextStyle(fontSize: 20),
                border: OutlineInputBorder(),
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
            ElevatedButton(
              onPressed: () async {
                String id = _idController.text;
                print("id: $id");
                String password = _passwordController.text;
                print("password: $password");
                String result = await loginUser(id, password);
                print("result: $result");

                if (result == '로그인 성공') {
                  print("성공!");
                  // 로그인 성공 시 원하는 동작 수행
                  // 예를 들어, 다음 화면으로 이동하거나 특정 작업을 수행합니다.
                  Navigator.pushReplacementNamed(context, '/home'); // 예시: 홈 화면으로 이동
                } else {
                  print("!!!!!!!");
                  // 로그인 실패 시 다이얼로그로 실패 메시지 표시
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('로그인 실패'),
                      content: Text('아이디 또는 비밀번호가 올바르지 않습니다.'),
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
                }
              },
              style: ElevatedButton.styleFrom(
                primary: primaryColor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('로그인', style: TextStyle(fontSize: 30)),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('아직 회원이 아니신가요? ', style: TextStyle(fontSize: 16)),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                  child: const Text('회원가입', style: TextStyle(fontSize: 20)),
                  style: TextButton.styleFrom(
                    primary: primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}