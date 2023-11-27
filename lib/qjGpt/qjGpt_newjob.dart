import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qj_projec/qjGpt/qjGpt_myJob.dart';
import 'package:qj_projec/httpApi/api_qjGpt_newJob.dart';


class OtherLecture extends StatefulWidget {
  const OtherLecture({Key? key});

  @override
  _OtherLectureState createState() => _OtherLectureState();
}

//OtherLecture
class _OtherLectureState extends State<OtherLecture> {
  bool isGptLoadingVisible = false; // 로딩 페이지 표시 여부를 제어하기 위한 변수
  final TextEditingController _controller = TextEditingController();  // TextEditingController 생성

  Future<void> loadMyLecturePage() async {
    setState(() {
      isGptLoadingVisible = true; // 로딩 페이지 표시
    }
  );

  //final ApiService apiService = ApiService(); //api 연결

    // MyLecture 화면으로 이동
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OtherLecture()),
    );
  }

    Future<void> sendJob() async {
    final ApiService apiService = ApiService();  // ApiService 인스턴스 생성
    final String job = _controller.text;  // 텍스트 필드의 내용 가져오기

    // sendJob 메소드를 호출하여 job을 전송
    final Map<String, dynamic> response = await apiService.sendJob(job);

    print(response);  // 응답 출력
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = const Color.fromRGBO(45, 67, 77, 1);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0, // 상단 위치 조절
              child: SvgPicture.asset('assets/TopTheme.svg'),
            ),
            Positioned(
              top: 70,
              left: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 이전 페이지로 돌아가기
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/BackButton.svg'),
              ),
            ),
            Positioned(
              top: 170, // 상단 위치 조절
              child: SvgPicture.asset(
                'assets/QJLog.svg',
                width: 200,  // 너비 조절
                height: 200,  // 높이 조절
              ),
            ),
            Positioned(
              top: 370, // 상단 위치 조절
              child: Container(
                width: MediaQuery.of(context).size.width,  // 화면 너비를 가져와서 지정
                child: SvgPicture.asset('assets/OtherLectureBar_1.svg'),
              ),
            ),
            Positioned(
              top: 375, // 'OtherLectureBar_1' SVG 이미지 위에 위치
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 90),
                child: TextField(
                  controller: _controller,  // controller 설정
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '여기에 새로운 관심 직무를 써주세요',
                    hintStyle: TextStyle(fontSize: 14),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 280,
              child: GestureDetector(  // SvgPicture를 GestureDetector로 감싸서 onTap 이벤트를 처리
                onTap: () {
                  sendJob();  // sendJob 메소드를 호출하여 텍스트 필드의 내용을 전송
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NewLecture(job: _controller.text)),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: SvgPicture.asset('assets/sendButton.svg'),
                ),
              ),
            ),
            Positioned(
              bottom: 0, // 상단 위치 조절
              child: Container(
                width: MediaQuery.of(context).size.width,  // 화면 너비를 가져와서 지정
                child: SvgPicture.asset('assets/BottomTheme.svg'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GptLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, // 흰색 배경
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset('assets/GptLoading.svg'), // SVG 이미지
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(194, 183, 236, 255)),
          ), // 원형 로딩 모션
        ],
      ),
    );
  }
}


//NewLecture
class NewLecture extends StatefulWidget {
  final String job;

  const NewLecture({Key? key, required this.job}) : super(key: key);

  @override
  _NewLectureState createState() => _NewLectureState();
}

class _NewLectureState extends State<NewLecture> {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    
    final ApiService apiService = ApiService(); //api 연결

    Color textColor = const Color.fromRGBO(45, 67, 77, 1);
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0, // 상단 위치 조절
              child: SvgPicture.asset('assets/TopTheme.svg'),
            ),
            Positioned(
              top: 70,
              left: 25, // 상단 위치 조절
              child: InkWell(
                onTap: () {
                  // 이전 페이지로 돌아가기
                  Navigator.pop(context);
                },
                child: SvgPicture.asset('assets/BackButton.svg'),
              ),
            ),
            Positioned(
              top: 105, // 상단 위치 조절
              child: SvgPicture.asset('assets/TopQjBar.svg'),
            ),
            Positioned(
              top: 195, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseName.svg'),
            ),
            Positioned(
              top: 260, // 상단 위치 조절
              child: SvgPicture.asset('assets/CourseInfo.svg'),
            ),
            Positioned(
              top: 450, // 상단 위치 조절
              child: SvgPicture.asset('assets/QjLogoBack.svg'),
            ),
            FutureBuilder<Map<String, dynamic>>(
              future: apiService.sendJob(widget.job),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return GptLoading(); // GptLoading 위젯 반환
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null || snapshot.data!['result'] == null) {
                  return Text('No data fetched from API.');
                } else {
                  // API로부터 받아온 데이터를 저장
                  List result = snapshot.data!['result'];

                  // 각 아이템에서 'title', 'comment', 'score', 'details'만 추출
                  List<Map<String, dynamic>> extractedData = result.map((item) {
                    return {
                      'title': item['title'],
                      'comment': item['comment'],
                      'score': item['score'],
                      'details': item['details'],
                    };
                  }).toList();

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 206, left: 0.0, right: 0.0),  // 패딩 값 지정
                        child: Text(
                          '${extractedData[0]['title']}',
                          style: TextStyle(
                            fontSize: 15,     // 글자 크기
                            fontWeight: FontWeight.bold,  // 글자 두께
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Container(
                          height: MediaQuery.of(context).size.height - 290,
                          child: ListView.builder(
                            itemCount: extractedData[0]['details'].length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.fromLTRB(18, 0, 18, 10),
                                child: ListTile(
                                  leading: Text('Score: ${extractedData[0]['details'][index]['score']}'),  // leading 사용
                                  subtitle: Text('${extractedData[0]['details'][index]['comment']}'),  // title 사용
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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