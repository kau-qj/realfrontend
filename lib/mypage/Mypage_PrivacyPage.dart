import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/BackButton.svg'), // 뒤로가기 버튼 SVG 파일
          onPressed: () {
            Navigator.of(context).pop(); // 현재 화면을 스택에서 제거하여 이전 화면으로 돌아감
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min, // 자식들의 크기만큼 Row의 크기를 설정
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
              margin: const EdgeInsets.only(top: 15), // 아이콘을 조금 아래로 내립니다.
              child: SvgPicture.asset('assets/RoundTop.svg'),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 150,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(60.0),
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                Center(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start, // 텍스트를 왼쪽으로 정렬합니다.
                    children: [
                      const Text(
                        '학교정보', // 여기에 텍스트를 추가합니다.
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold, // 글씨체를 굵게 합니다.
                            fontSize: 16, // 글씨 크기를 설정합니다.
                            color: Color.fromARGB(
                                255, 117, 113, 113) //글씨 색상을 검은색으로 합니다.
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
                const Text(
                  '개인정보',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(255, 117, 113, 113),
                  ),
                ),
                const SizedBox(height: 10.0),
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
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    String school = _schoolController.text;
                    String major = _majorController.text;
                    String year = _year;

                    String name = _nameController.text;
                    String contact = _contactController.text;

                    // HTTP 요청 대신에 원하는 동작을 수행하도록 처리합니다.
                    // 예를 들어, 회원 가입 로직을 구현하거나 다른 동작을 수행할 수 있습니다.
                    // 원하는 동작을 추가로 구현하면 됩니다.
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
                  ),
                ),
                const SizedBox(height: 0.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
