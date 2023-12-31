//mypage_profile
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qj_projec/httpApi/api_Mypage/api_mypage_profile.dart';

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
    _isImageUpdated = false;
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
      print('Error fetching user profile: $e');
    }
  }

  void _saveProfile() async {
    try {
      final ApiService _apiService = ApiService();

      // 이전에 설정된 imageUrl을 유지하고, 새로운 이미지가 선택되었을 때만 업데이트
      String? updatedImageUrl = _isImageUpdated ? imageUrl : imageUrl;
      print("989989: $updatedImageUrl");

      await _apiService.saveProfile(
        nickName: nickNameController.text,
        jobName: jobNameController.text,
        imageUrl: updatedImageUrl, // 새로운 이미지 또는 기존 이미지 URL
      );

      Navigator.of(context).pop({
        'nickName': nickNameController.text,
        'jobName': jobNameController.text,
        'imageUrl': updatedImageUrl
      });
    } catch (e) {
      print('Error saving user profile: $e');
    }
  }

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('갤러리에서 선택하기'),
                  onTap: () {
                    _openGallery();
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('기본 이미지 사용하기'),
                onTap: () {
                  setState(() {
                    imageUrl = 'assets/profile.png'; // 기본 이미지 경로 설정
                    _isImageUpdated = true;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _openGallery() async {
    final ImagePicker _picker = ImagePicker();
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          imageUrl = image.path; // 로컬 이미지 파일 경로로 업데이트
          _isImageUpdated = true;
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during image selection: $e');
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
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '프로필 설정',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            /*const SizedBox(width: 10),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: SvgPicture.asset('assets/RoundTop.svg'),
            )*/
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        toolbarHeight: 120,
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
                        backgroundImage:
                            imageUrl != null && imageUrl!.startsWith('http')
                                ? NetworkImage(imageUrl!) as ImageProvider
                                : AssetImage('assets/profile.png')
                                    as ImageProvider, // 이 부분 수정
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
                controller: nickNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
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