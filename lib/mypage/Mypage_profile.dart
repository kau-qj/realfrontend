import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../httpApi/api_Mypage/api_mypage_profile.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  String? nickName;
  String? jobName;
  String? imageUrl;
  TextEditingController nickNameController = TextEditingController();
  TextEditingController jobNameController = TextEditingController();
  bool _isImageUpdated = false;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  @override
  void dispose() {
    jobNameController.dispose();
    super.dispose();
  }

  void _fetchUserProfile() async {
    try {
      final ApiService _apiService = ApiService();
      final userProfile = await _apiService.fetchUserProfile();
      setState(() {
        nickName = userProfile['nickName'] as String?;
        jobName = userProfile['jobName'] as String?;
        imageUrl = userProfile['imageUrl'] as String?;
        nickNameController.text = nickName ?? '';
        jobNameController.text = jobName ?? '';
      });
    } catch (e) {
      // 에러 처리
      print('Error fetching user profile: $e');
    }
  }

  void _saveProfile() async {
    // TextField에서 입력한 값을 nickName 및 jobName 변수에 할당
    nickName = nickNameController.text;
    jobName = jobNameController.text;
    
    var uri = Uri.parse('https://kauqj.shop/mypage/profile');
    var request = http.MultipartRequest('PUT', uri)
      ..fields['nickName'] = nickNameController.text //nickName값을 업데이트
      ..fields['jobName'] = jobNameController.text; //jobName도 업데이트

    // 새 이미지가 선택되었고, 로컬 파일 경로인 경우에만 이미지 업로드를 수행합니다.
    if (_isImageUpdated && imageUrl != null && File(imageUrl!).existsSync()) {
      request.files.add(await http.MultipartFile.fromPath(
        'profileImage',
        imageUrl!,
        contentType: MediaType('image', 'jpeg'),
      ));
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        print('프로필 업데이트 성공');
        final respStr = await response.stream.bytesToString();
        print(respStr); // 서버 응답 출력

        // 새 이미지가 업데이트되지 않았다면 기존 imageUrl 유지
        String updatedImageUrl =
            _isImageUpdated && imageUrl != null && File(imageUrl!).existsSync()
                ? imageUrl!
                : (imageUrl ?? 'assets/profile.png');

        setState(() {
          nickName = nickNameController.text; // nickName 값을 업데이트
          // job과 imageUrl을 MyPage로 전달
          Navigator.of(context).pop({
            'jobName': jobNameController.text,
            'imageUrl': updatedImageUrl,
          });
        });
      } else {
        print('프로필 업데이트 실패: ${response.statusCode}');
      }
    } catch (e) {
      print("프로필 업데이트 에러: $e");
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          imageUrl = image.path;
          _isImageUpdated = true; // 새 이미지가 선택되었음을 나타냄
        });
      }
    } catch (e) {
      // 에러 처리
      if (kDebugMode) {
        print('Image pick cancelled or failed: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _imageSize = MediaQuery.of(context).size.width / 4;
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/BackButton.svg'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
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
              margin: const EdgeInsets.only(top: 15),
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
              SizedBox(height: screenSize.height * 0.01),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        backgroundImage: imageUrl != null &&
                                imageUrl!.isNotEmpty
                            ? NetworkImage(imageUrl!) as ImageProvider
                            : AssetImage('assets/profile.png') as ImageProvider,
                        radius: _imageSize / 2,
                      ),
                    ),
                    SvgPicture.asset('assets/profilePlus.svg'),
                  ],
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              const Text(
                '닉네임',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(236, 0, 0, 0),
                ),
              ),
              SizedBox(height: screenSize.height * 0.01),
              TextField(
                controller: TextEditingController(text: nickName),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                onChanged: (value) {
                  setState(() {
                    nickName = value;
                  });
                },
              ),
              SizedBox(height: screenSize.height * 0.02),
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
                controller: jobNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                onChanged: (value) {
                  setState(() {
                    jobName = value;
                    print("jobName updated to: $jobName"); // 디버그 콘솔 출력
                  });
                },
              ),
              SizedBox(height: screenSize.height * 0.02),
              const Text(
                '• 작성된 내용 검토 후'
                '\n• 욕설이나 내용이 있는 경우'
                '\n• QJ 서비스 이용 약관에 따라 부적절하다고 판단될 경우'
                '\n노출 제한 처리와 서비스 이용에 제한이 생길 수 있습니다',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Poppins',
                  color: Color.fromARGB(236, 150, 150, 150),
                ),
              ),
              SizedBox(height: screenSize.height * 0.04),
              Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: _saveProfile,
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