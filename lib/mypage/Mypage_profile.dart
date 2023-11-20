import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
//import 'package:qj_projec/httpApi/api_MypageProfile.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  String? _imageUrl;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _imageUrl = image.path;
        });
      }
    } catch (e) {
      // Handle errors or user cancellation
      if (kDebugMode) {
        print('Image pick cancelled or failed: $e');
      }
    }
  }

  Future<void> _fetchImage() async {
    // 이미지 가져오기 로직 구현...
    // 예시: http 패키지를 사용하여 이미지를 가져오는 경우
    final response = await http.get(Uri.parse(
        'https://kau-sanhak-qj.s3.ap-northeast-2.amazonaws.com/1699688431867-KakaoTalk_20231111_161348208.png'));
    if (response.statusCode == 200) {
      setState(() {
        _imageUrl = response.body; // 이미지 URL을 저장
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchImage();
  }

  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 4;

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
              '프로필 설정',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: _imageUrl != null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(_imageUrl!),
                              radius: _imageSize / 2,
                            )
                          : Image.asset(
                              'assets/profile.png',
                              width: 91,
                              height: 91,
                            ),
                    ),
                    SvgPicture.asset('assets/profilePlus.svg'),
                  ],
                ),
              ),

              const SizedBox(height: 30), // 닉네임 입력란과의 간격 조정
              const Text(
                '닉네임',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(236, 0, 0, 0),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // 모서리 반경을 20으로 설정
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10), // 내부 패딩을 조절
                ),
              ),
              SizedBox(height: 20), // 관심직무 입력란과의 간격 조정
              const Text(
                '나의 관심직무',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(236, 0, 0, 0),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), // 모서리 반경을 20으로 설정
                  ),
                  contentPadding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10), // 내부 패딩을 조절
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5, // 입력란의 라인 수
              ),
              SizedBox(height: 20), // 설명 텍스트와의 간격 조정
              const Text(
                '• 작성된 내용 검토 후\n•욕설이나 내용이 있는 경우\n• QJ 서비스 이용 약관에 따라 부적절하다고 판단될 경우\n 노출 제한 처리와 서비스 이용에 제한이 생길 수 있습니다',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(236, 150, 150, 150),
                ),
              ),
              SizedBox(height: 50), // 간격 조정
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: SvgPicture.asset('assets/RoundButton.svg'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
