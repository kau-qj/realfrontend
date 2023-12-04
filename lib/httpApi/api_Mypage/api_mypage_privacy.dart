import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:collection/collection.dart';
import 'package:qj_projec/httpApi/cookie_utils.dart';

class ApiService {
  final String baseUrl = 'https://kauqj.shop';

  // 사용자 정보를 가져오는 메서드
  Future<Map<String, dynamic>> fetchPrivacy() async {
    final String endpoint = '/mypage/info'; // 엔드포인트를 /mypage/info로 변경
    final uri = Uri.parse('$baseUrl$endpoint');
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

    try {
      final response = await http.get(uri, headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['isSuccess'] && data['result'] != null) {
          // 필요한 정보만 추출하여 반환
          return {
            'userName': data['result']['userName'],
            'major': data['result']['major'],
            'grade': data['result']['grade'],
            'school': data['result']['school'],
            'phoneNum': data['result']['phoneNum']
          };
        } else {
          throw Exception('Result key is not found in the response');
        }
      } else {
        throw Exception('Failed to connect to the server');
      }
    } catch (e) {
      throw Exception('Error fetching user info: $e');
    }
  }

  Future<void> savePrivacy({
    required String userName,
    required String major,
    required String grade,
    required String school,
    required String phoneNum,
  }) async {
    final uri = Uri.parse('$baseUrl/mypage/info');
    String jwtToken = await _getJWTToken();

    try {
      final cookies = await cookieJar.loadForRequest(uri);
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
        'Cookie': cookies.map((c) => '${c.name}=${c.value}').join('; ')
      };

      var body = jsonEncode({
        'userName': userName,
        'major': major,
        'grade': grade,
        'school': school,
        'phoneNum': phoneNum,
      });

      var response = await http.put(uri, headers: headers, body: body);
      var data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['isSuccess'] == true) {
        print('개인정보 업데이트 성공');
      } else {
        print('개인정보 업데이트 실패: ${data['message']}');
      }
    } catch (e) {
      print('개인정보 업데이트 에러: $e');
    }
  }

  Future<String> _getJWTToken() async {
    // 로그인된 사용자의 JWT 토큰을 얻어옴
    final uri = Uri.parse('https://kauqj.shop');
    final cookies = await cookieJar.loadForRequest(uri);
    final jwt =
        cookies.firstWhereOrNull((cookie) => cookie.name == 'access_token');

    // jwt가 null인 경우 예외를 던지거나 기본값을 반환하도록 처리할 수 있습니다.
    if (jwt == null) {
      throw Exception('JWT 토큰을 찾을 수 없습니다.');
      // 또는 기본값 반환: return '기본값';
    }

    // 'access_token='을 포함한 토큰 전체 문자열을 반환
    return jwt.value;
  }
}