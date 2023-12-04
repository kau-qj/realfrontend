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
  final ApiService apiService = ApiService(); //api 연결
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
    
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 70,
              left: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 이전 페이지로 돌아가기
                  Navigator.pop(context);
                },
              child: Row(
                children: [
                  SvgPicture.asset('assets/BackButton.svg'),
                  SizedBox(width: 20),  // SVG 이미지와 텍스트 사이의 간격
                  Text('QJ 보관함', style: TextStyle(fontSize: 23))  // 텍스트 추가
                ],
              ),
              ),
            ),
            Positioned(
              top: 50,
              right: 0, // 상단 위치 조절
              child: SvgPicture.asset('assets/RoundTop.svg'),
            ),
            FutureBuilder<List<dynamic>>(
              future: apiService.fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Container(
                    height: MediaQuery.of(context).size.height - 0,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      itemCount: snapshot.data!.length,
                      separatorBuilder: (context, index) => SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        var item = snapshot.data![index];
                        return GestureDetector(
                          onTap: () => _navigateToQjStorage(context, item['setIdx']),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/QjStorageBox.svg',
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 100,
                              ),
                              Positioned(
                                top: 25,
                                child: Column(
                                  children: [
                                    Text(
                                      item['title'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Poppins'),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: 5),
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
                    ),
                  );
                }
              },
            ),
          ]
        ),
      ),
    );
  }
}
