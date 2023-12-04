import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:qj_projec/httpApi/api_Mypage/api_mypage_privacy.dart';
import 'package:qj_projec/httpApi/cookie_utils.dart';
import 'package:collection/collection.dart';

class PrivacyPage extends StatefulWidget {
  const PrivacyPage({Key? key}) : super(key: key);

  @override
  _PrivacyPageState createState() => _PrivacyPageState();
}

class _PrivacyPageState extends State<PrivacyPage> {
  TextEditingController _schoolController = TextEditingController();
  TextEditingController _majorController = TextEditingController();
  String _grade = '1';
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _phoneNumController = TextEditingController();
  Color primaryColor = Color.fromRGBO(161, 196, 253, 1);
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchPrivacy();
  }

  void _fetchPrivacy() async {
    try {
      final userInfo = await _apiService.fetchPrivacy();
      setState(() {
        _userNameController.text = userInfo['userName'];
        _majorController.text = userInfo['major'];
        _grade = userInfo['grade'].toString();
        _schoolController.text = userInfo['school'];
        _phoneNumController.text = userInfo['phoneNum'];
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<void> _savePrivacy() async {
    try {
      await _apiService.savePrivacy(
        userName: _userNameController.text,
        major: _majorController.text,
        grade: _grade,
        school: _schoolController.text,
        phoneNum: _phoneNumController.text,
      );
      Navigator.pop(context);
    } catch (e) {
      print('Error saving user data: $e');
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
                    controller: _userNameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      labelText: '이름',
                      border: UnderlineInputBorder(),
                      prefixIcon: Icon(Icons.person, color: primaryColor),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _phoneNumController,
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