// api_profile.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:collection/collection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qj_projec/httpApi/cookie_utils.dart';

class ApiService {
  final String baseUrl = 'https://kauqj.shop';

  // 사용자 정보를 가져오는 메서드
  Future<Map<String, dynamic>> fetchUserProfile() async {
    final String endpoint = '/mypage/profile';
    final uri = Uri.parse(baseUrl);
    final cookies = await cookieJar.loadForRequest(uri);

    String jwtToken = '';

    final jwt =
        cookies.firstWhereOrNull((cookie) => cookie.name == 'access_token');

    if (jwt != null) {
      jwtToken = jwt.value;
    } else {
      throw Exception('토큰이 존재하지 않습니다. 로그인이 필요합니다.');
    }

    final headers = {
      'Cookie': cookies.map((c) => '${c.name}=${c.value}').join('; '),
      'Authorization': 'Bearer $jwtToken'
    };

    final response =
        await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['isSuccess'] && data['result'] != null) {
        String? nickName = data['result']['nickName'];
        String? jobName = data['result']['jobName'];
        String? imageUrl = data['result']['imageUrl'];
        String? parsedImageUrl;

        print('dkdkdk: $imageUrl');
        print('xcxcxc: $parsedImageUrl');
        if (imageUrl != null && imageUrl.isNotEmpty) {
          try {
            final uri = Uri.parse(imageUrl);
            parsedImageUrl = uri.toString();
          } catch (e) {
            print('Invalid URL: $imageUrl');
          }
        }

        return {
          'nickName': nickName ?? '',
          'jobName': jobName ?? '',
          'imageUrl': parsedImageUrl ??
              'assets/profile.png', // URL이 유효하지 않으면 기본 이미지 경로 사용
        };
      } else {
        throw Exception('Result key is not found in the response');
      }
    } else {
      throw Exception(
          'Failed to load user profile. Status code: ${response.statusCode}');
    }
  }

  Future<void> saveProfile({
    required String nickName,
    required String jobName,
    String? imageUrl,
  }) async {
    final uri = Uri.parse('$baseUrl/mypage/profile');
    String jwtToken = await _getJWTToken();

    try {
      final cookies = await cookieJar.loadForRequest(uri);
      final headers = {
        'Authorization': 'Bearer $jwtToken',
        'Cookie': cookies.map((c) => '${c.name}=${c.value}').join('; ')
      };

      var request = http.MultipartRequest('PUT', uri)
        ..headers.addAll(headers)
        ..fields['nickName'] = nickName
        ..fields['jobName'] = jobName;

      if (imageUrl != null) {
        if (imageUrl.startsWith('http')) {
          // Case 3: S3 URL provided directly
          request.fields['s3ImageUrl'] = imageUrl;
        } else if (!imageUrl.startsWith('assets')) {
          // Case 1: Image file uploaded
          request.files
              .add(await http.MultipartFile.fromPath('profileImage', imageUrl));
        }
      }
      print('0909: ${request.fields}');

      var response = await http.Response.fromStream(await request.send());
      print('제밝:${response.body}');
      var data = jsonDecode(response.body);
      print('dadada:$data');
      if (response.statusCode == 200 && data['isSuccess'] == true) {
        print('프로필 업데이트 성공');
      } else {
        print('프로필 업데이트 실패: ${data['message']}');
      }
    } catch (e) {
      print('프로필 업데이트 오류: $e');
    }
  }

  Future<String> _getJWTToken() async {
    // 로그인된 사용자의 JWT 토큰을 얻어옴
    final uri = Uri.parse('https://kauqj.shop');
    final cookies = await cookieJar.loadForRequest(uri);
    final jwt =
        cookies.firstWhereOrNull((cookie) => cookie.name == 'access_token');

    if (jwt == null) {
      throw Exception('JWT 토큰을 찾을 수 없습니다.');
    }

    // 'access_token='을 포함한 토큰 전체 문자열을 반환
    return jwt.name + '=' + jwt.value; // 이렇게 변경
  }
}