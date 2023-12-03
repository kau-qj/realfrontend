import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qj_projec/httpApi/api_Mypage/api_mypage_Storage.dart';
import 'Mypage_QJstorage.dart';

class Storage extends StatefulWidget {
  const Storage({Key? key}) : super(key: key);

  @override
  _StorageState createState() => _StorageState();
}

class _StorageState extends State<Storage> {
  //Future<List<dynamic>> async;

  @override
  void initState() {
    super.initState();
    final ApiService apiService = ApiService(); //api 연결fetchData
  }

  void _navigateToQjStorage(BuildContext context, int setIdx) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => QJStorage(setIdx: setIdx)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ApiService apiService = ApiService(); //api 연결
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
              'QJ 보관함',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              margin: const EdgeInsets.only(top: 0), // 아이콘을 조금 아래로 내립니다.
              child: SvgPicture.asset('assets/RoundTop.svg',
                  fit: BoxFit.scaleDown),
            )
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 150,
        elevation: 0,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: apiService.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: 10), // 간격을 조절합니다.
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return GestureDetector(
                  onTap: () => _navigateToQjStorage(context, item['setIdx']),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/QjStorageBox.svg',
                        // 이미지 크기를 조절
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 100,
                      ),
                      Positioned(
                        top: 25, // 이 값을 조절하여 텍스트 위치를 조정합니다.
                        child: Column(
                          children: [
                            Text(
                              item['title'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 5), //타이틀과 createAt 사이
                            Text(
                              item['createAt'],
                              style: TextStyle(fontFamily: 'Poppins'),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}