import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qj_projec/httpApi/api_login.dart';

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

  Future<void> _login() async {
  String userId = _emailController.text;
  String userPw = _passwordController.text;
  try {
    // 이 부분에서 context를 추가해서 loginUser 함수를 호출합니다.
    String result = await loginUser(userId, userPw, context);
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
  } catch (error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('로그인 실패'),
        content: Text(error.toString()),
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
}

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Positioned(
            right: 0,
            top: screenHeight * 0.011,
            child: SvgPicture.asset(
              'assets/LoginPageCircle.svg',
              height: 230,
              width: 230,
            ),
          ),
          Positioned(
            left: 0,
            bottom: screenHeight * 0.0001,
            child: SvgPicture.asset(
              'assets/LoginPageCircle2.svg',
              height: 190,
              width: 190,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                  onTap: _login,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}