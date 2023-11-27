import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qj_projec/mypage/Mypage_storage.dart';
import 'package:qj_projec/httpApi/api_jobdetails.dart';
import 'package:flutter_html/flutter_html.dart';


class JobDetails extends StatelessWidget {
  //const jobdetails({super.key});
  final String jobname;
  final ApiService apiService = ApiService(); //api 연결

  JobDetails({required this.jobname}); // 생성자에서 jobname 파라미터를 필수로 받도록 설정
  
  String convertNewlinesToBreaks(String text) {
    return text.replaceAll('\n', '<br>');
  }

  @override
  Widget build(BuildContext context) {
    Color textColor1 = const Color.fromRGBO(161, 196, 253, 1);
    Color textColor2 = const Color.fromRGBO(45, 67, 77, 1);

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            
            Positioned(
              top: 110,
              child: Text(
                "진로 사전",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: textColor1,
                ),
              ),
            ),
            /*
            Positioned(
              top: 150,
              left: 25,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/BackButton.svg'),
              ),
            ),
            */
            Positioned(
              top: 50,
              left: 0,
              child: SvgPicture.asset('assets/smallQj.svg'),
            ),
            Positioned(
              top: 45,
              height: 915,
              width: 370,
              child: SvgPicture.asset('assets/jobDetailsBox.svg'),
            ),
            Positioned(
              top: 195,
              right: 25,
              child: InkWell(
                // AddButton의 onTap 메소드
                onTap: () async {
                  // 사용자의 관심 직무가 이미 등록되어 있는지 확인
                  // 이 부분은 실제 앱에서는 사용자의 관심 직무 정보를 관리하는 로직에 따라 달라집니다.
                  bool isJobRegistered = true;

                  if (isJobRegistered) {
                    // 이미 관심 직무가 등록되어 있으면 AlertDialog를 표시
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: textColor1, width: 2),
                            borderRadius: BorderRadius.circular(30.0), // 테두리 둥글게 설정
                          ),
                          title: Text(
                            '관심 직무 등록',
                            style: TextStyle(
                              color: textColor2,
                              fontWeight: FontWeight.bold,

                            ),
                          ),
                          content: Text(
                            '최대 한 개의 관심직무 등록이 가능합니다. 관심직무를 수정하시겠습니까?',
                            style: TextStyle(
                              color: textColor2,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                '아니오',
                                style: TextStyle(
                                  color: textColor1,
                                  fontWeight: FontWeight.bold,
                                ), // 아니오 버튼의 글씨 색상을 빨간색으로 변경
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();  // 닫기
                              },
                            ),
                            TextButton(
                              child: Text(
                                '예',
                                style: TextStyle(
                                  color: textColor1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),                              
                              onPressed: () {
                                // 예를 선택하면 관심 직무를 수정하는 로직을 실행
                                // 이 부분은 실제 앱에서는 관심 직무 정보를 수정하는 로직에 따라 달라집니다.
                                Navigator.of(context).pop();  // 닫기
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    // 관심 직무가 등록되어 있지 않으면 직무를 등록하는 로직을 실행
                    // 이 부분은 실제 앱에서는 관심 직무 정보를 등록하는 로직에 따라 달라집니다.
                  }
                },
                child: SvgPicture.asset('assets/AddButton.svg'),
              ),
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: apiService.fetchData(jobname),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!['result'] == null) {
                  return Text('No data fetched from API.');
                } else {
                  // API로부터 받아온 데이터를 저장
                  Map<String, dynamic> result = snapshot.data!['result'];

                  // 'jobname', 'comments', 'imageUrl'만 추출
                  Map<String, dynamic> extractedData = {
                    'jobname': result['jobname'],
                    'comments': result['comments'],
                    'imageUrl': result['imageUrl'],
                  };

                  return Positioned(
                    top: 245,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height - 290,
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 40),  // 패딩 값 지정
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),  // 곡선 반지름 설정
                            child: Image.network('${extractedData['imageUrl']}'),
                          ),
                          SizedBox(height: 10),
                          Text(
                            '${extractedData['jobname']}',
                            style: TextStyle(
                              fontSize: 16,     // 글자 크기
                              fontWeight: FontWeight.bold,  // 글자 두께
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 30),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 0),
                            child: Html(
                              data: convertNewlinesToBreaks('${extractedData['comments']}'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
