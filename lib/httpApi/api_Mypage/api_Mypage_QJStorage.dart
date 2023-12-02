import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:qj_projec/httpApi/cookie_utils.dart';

class ApiService {
  // 기본 URL
  final String baseUrl = 'https://kauqj.shop';

  // 특정 setIdx에 대한 코스 세부 정보를 가져오는 메소드
  Future<List<dynamic>> fetchCourseDetails(int setIdx) async {
    final String endpoint = '/mypage/qj/$setIdx'; // API의 엔드포인트
    final uri = Uri.parse(baseUrl);
    final cookies = await cookieJar.loadForRequest(uri);
    String jwtToken = '';

    // 기존 코드에서 쿠키 이름이 'access_token'인 것을 찾도록 수정
    final jwt = cookies.firstWhereOrNull((cookie) => cookie.name == 'access_token');

    if (jwt != null) {
      jwtToken = jwt.value;  // 찾은 경우 토큰 값을 설정
    } else {
      // jwtToken이 비었을 경우의 처리 추가
      throw Exception('토큰이 존재하지 않습니다. 로그인이 필요합니다.');
    }

    // 'Bearer' 헤더에 적절한 토큰 값을 설정
    final headers = {
      'Cookie': cookies.map((c) => '${c.name}=${c.value}').join('; '),
      'Authorization': 'Bearer $jwtToken'
    };
    
    final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      // 로그 출력 추가
      print('Data fetched successfully for setIdx: $setIdx');
      return data['result'];
    } else {
      // 오류 발생 시 로그 출력 추가
      print('Request failed with status: ${response.statusCode}.');
      throw Exception(
          'Failed to load course details with status code: ${response.statusCode}');
    }
  }
}
