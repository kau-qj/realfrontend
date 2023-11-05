import 'package:flutter/material.dart';

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
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _schoolController,
              decoration: InputDecoration(
                labelText: '학교',
                border: UnderlineInputBorder(),
                prefixIcon: Icon(Icons.school, color: primaryColor),
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
            const SizedBox(height: 16.0),
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
                primary: primaryColor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Text('회원가입', style: TextStyle(fontSize: 25)), // '회원가입' 글자 크기를 25로 수정하였습니다.
            ),
          ],
        ),
      ),
    );
  }
}