import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qj_projec/mypage/Mypage_storage.dart';
import 'package:qj_projec/httpApi/api_jobdetails.dart';

class JobDetails extends StatelessWidget {
  //const jobdetails({super.key});
  final String jobname;
  final ApiService apiService = ApiService(); //api 연결

  JobDetails({required this.jobname}); // 생성자에서 jobname 파라미터를 필수로 받도록 설정

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color.fromRGBO(161, 196, 253, 0.94);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 50,
              left: 0,
              child: SvgPicture.asset('assets/smallQj.svg'),
            ),
            Positioned(
              top: 110,
              child: Text(
                "진로 사전",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: textColor,
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
              top: 170,
              child: SvgPicture.asset('assets/jobDetailsBox.svg'),
            ),
            Positioned(
              top: 190,
              right: 25,
              child: InkWell(
                onTap: () {
                  // 마이페이지 관심직무에 추가되도록 설정
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
                            padding: EdgeInsets.symmetric(horizontal: 0),  // 좌우 패딩 값 설정
                            child: Text(
                              '${extractedData['comments']}',
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
