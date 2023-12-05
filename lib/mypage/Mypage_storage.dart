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
  final ApiService apiService = ApiService(); // API 연결
  String sortOrder = '최신순'; // 정렬 순서를 저장하는 변수

  void _navigateToQjStorage(BuildContext context, int setIdx) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => QJStorage(setIdx: setIdx)),
    );
  }

  List<dynamic> sortData(List<dynamic> data) {
    List<dynamic> sortedData = [...data];
    if (sortOrder == '최신순') {
      sortedData.sort((a, b) => DateTime.parse(b['createAt'])
          .compareTo(DateTime.parse(a['createAt'])));
    } else {
      sortedData.sort((a, b) => DateTime.parse(a['createAt'])
          .compareTo(DateTime.parse(b['createAt'])));
    }
    return sortedData;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: screenSize.height * 0.1,
              left: screenSize.width * 0.05,
              child: InkWell(
                onTap: () {
                  // 이전 페이지로 돌아가기
                  Navigator.pop(context);
                },
                child: Row(
                  children: [
                    SvgPicture.asset('assets/BackButton.svg'),
                    SizedBox(
                        width: screenSize.width * 0.05), // SVG 이미지와 텍스트 사이의 간격
                    Text('QJ 보관함',
                        style: TextStyle(
                            fontSize: screenSize.width * 0.06)) // 텍스트 추가
                  ],
                ),
              ),
            ),
            Positioned(
              top: screenSize.height * 0.15,
              right: screenSize.width * 0.12,
              child: DropdownButton<String>(
                value: sortOrder,
                iconEnabledColor: Color.fromARGB(255, 155, 204, 244),
                items: <String>['최신순', '오래된 순']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    sortOrder = newValue!;
                  });
                },
              ),
            ),
            Positioned(
              top: 0,
              right: 0, // 상단 위치 조절
              child: SvgPicture.asset('assets/RoundTop.svg'),
            ),
            Positioned(
              top: screenSize.height * 0.23,
              bottom: 0,
              left: 0,
              right: 0,
              child: FutureBuilder<List<dynamic>>(
                future: apiService.fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List<dynamic> sortedData = sortData(snapshot.data!);
                    return ListView.separated(
                      padding: EdgeInsets.symmetric(
                          horizontal: screenSize.width * 0.05),
                      itemCount: sortedData.length,
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        var item = sortedData[index];
                        return GestureDetector(
                          onTap: () =>
                              _navigateToQjStorage(context, item['setIdx']),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/QjStorageBox.svg',
                                width: screenSize.width * 0.8,
                                height: screenSize.height * 0.1,
                              ),
                              Positioned(
                                top: screenSize.height * 0.02,
                                child: Column(
                                  children: [
                                    Text(
                                      item['title'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins',
                                        fontSize: screenSize.width * 0.04,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(height: screenSize.height * 0.01),
                                    Text(
                                      item['createAt'],
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: screenSize.width * 0.035,
                                      ),
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
            ),
          ],
        ),
      ),
    );
  }
}