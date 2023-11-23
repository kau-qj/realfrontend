import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qj_projec/login_page/login_page.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top:20, left: 45.0, right: 45.0, bottom: 20),
        child: Stack(
          children: <Widget>[
            /*
            Positioned(
              top: 20,
              left: 5,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: SvgPicture.asset('assets/BackButton.svg'),
              ),
            ),
            */
            
            ListView(
              children: <Widget>[
                Center(
                  child: TextField(
                    controller: _schoolController,
                    decoration: InputDecoration(
                      labelText: '학교',
                      border: UnderlineInputBorder(),
                      prefixIcon: Icon(Icons.school, color: primaryColor),
                    ),
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
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(Icons.school, color: primaryColor),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _interestController,
                  decoration: InputDecoration(
                    labelText: '관심직무',
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(Icons.workspace_premium, color: primaryColor),
                  ),
                ),
                const SizedBox(height: 16.0),
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
                const SizedBox(height: 16.0),
                TextField(
                  controller: _userIdController,
                  decoration: InputDecoration(
                    labelText: '아이디',
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(Icons.account_circle, color: primaryColor),
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: '비밀번호',
                    border: UnderlineInputBorder(),
                    prefixIcon: Icon(Icons.lock, color: primaryColor),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    String school = _schoolController.text;
                    String major = _majorController.text;
                    String year = _year;
                    String interest = _interestController.text;
                    String name = _nameController.text;
                    String contact = _contactController.text;
                    String userId = _userIdController.text;
                    String userPw = _passwordController.text;
                    // http 요청 대신에 원하는 동작을 수행하도록 처리합니다.
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
                        style: TextStyle(fontSize: 23, color: Colors.white),
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
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
          ],
        ),
      ),
    );
  }
}