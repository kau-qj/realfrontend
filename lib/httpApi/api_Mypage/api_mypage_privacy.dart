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
}