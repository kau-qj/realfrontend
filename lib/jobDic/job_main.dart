import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qj_projec/jobDic/job_details.dart';
import 'package:qj_projec/httpApi/api_job_main.dart';


class JobDictionary extends StatefulWidget {
  const JobDictionary({super.key});

  @override
  State<JobDictionary> createState() => _JobDictionaryState();
}

class _JobDictionaryState extends State<JobDictionary> {
  final TextEditingController _searchController = TextEditingController();
  Color textColor = const Color.fromRGBO(161, 196, 253, 0.94);
  Future<Map<String, dynamic>>? _fetchDataFuture;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  final ApiService apiService = ApiService(); //api 연결
  bool isListVisible = false; // 목록창의 가시성 상태를 저장하는 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 390,
              left: 0,
              child: SvgPicture.asset('assets/CourseRecO1.svg'),
            ),
            Positioned(
              top: 280,
              child: Text(
                "QJ 진로 사전",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
            Positioned(
              top: 340,
              left: 30,
              right: 30,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: TextField(
                  readOnly: true, // 키보드가 나타나지 않도록 설정
                  controller: _searchController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    hintText: '클릭하여 진로를 찾아보세요!',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear, color: Colors.grey),
                      onPressed: () => _searchController.clear(),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      isListVisible = true; // 목록창을 표시하기 위해 가시성 상태를 true로 변경
                    });
                  },
                  onChanged: (value) {
                    // 검색어 변경 시 동작할 로직 추가
                  },
                ),
              ),
            ),
            if (isListVisible) // 목록창 가시성 상태에 따라 표시
              Positioned(
                top: 340 + 59, // 검색창 바로 아래에 위치하도록 top 값을 조절
                left: 60,
                right: 60,
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    border: Border.all( // 테두리 설정
                      color: Color.fromRGBO(161, 196, 253, 0.94), // 테두리 색상
                      width: 1, // 테두리 두께
                    ),
                  ),
                  // 목록창의 내용 및 스타일 설정
                  child: FutureBuilder<Map<String, dynamic>>(
                    future: apiService.fetchData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!['result'] == null) {
                        return Text('No data fetched from API.');
                      } else {
                        // API로부터 받아온 데이터를 저장
                        List result = snapshot.data!['result'];

                        // 각 아이템에서 '---'만 추출
                        List<String> titles = result.map((item) => item['jobname'] as String).toList();

                        return ListView.builder(
                          itemCount: titles.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: index == 0 ? EdgeInsets.fromLTRB(0, 0, 0, 0) : EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: ListTile(
                                title: Text(titles[index]),
                                onTap: () { // 항목을 탭했을 때의 이벤트를 정의
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobDetails(jobName: titles[index]), // 선택한 항목의 값을 파라미터로 전달
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            /*
            FutureBuilder<Map<String, dynamic>>(
              future: apiService.fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!['result'] == null) {
                  return Text('No data fetched from API.');
                } else {
                  // API로부터 받아온 데이터를 저장
                  List result = snapshot.data!['result'];

                  // 각 아이템에서 '---'만 추출
                  List<String> titles = result.map((item) => item['jobname'] as String).toList();

                  return ListView.builder(
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(titles[index]),
                      );
                    },
                  );
                }
              },
            ),
            */
          ],
        ),
      ),
    );
  }
}