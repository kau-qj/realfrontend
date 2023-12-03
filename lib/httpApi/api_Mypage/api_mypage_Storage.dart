import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:qj_projec/httpApi/cookie_utils.dart';

class ApiService {
  final String baseUrl = 'https://kauqj.shop'; // API의 기본 URL
  final String endpoint = '/mypage/qj'; // API의 엔드포인트

  Future<List<dynamic>> fetchData() async {
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


    Map<String, dynamic> data = json.decode(response.body);
    dynamic result = data['result'];
    if (result is List) {
      return result;
    } else {
      throw Exception('Failed to parse data. Expected type: List, Actual type: ${result.runtimeType}');
    }
  }
}