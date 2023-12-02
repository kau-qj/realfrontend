import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:collection/collection.dart';
import 'package:qj_projec/httpApi/cookie_utils.dart';

class ApiService {
  final String baseUrl = 'https://kauqj.shop';

  // 사용자 정보를 가져오는 메서드
  Future<Map<String, dynamic>> fetchUserInfo() async {
    final String endpoint = '/mypage';
    final uri = Uri.parse(baseUrl);
    final cookies = await cookieJar.loadForRequest(uri);

    String jwtToken = '';

    // 기존 코드에서 쿠키 이름이 'access_token'인 것을 찾도록 수정
    final jwt =
        cookies.firstWhereOrNull((cookie) => cookie.name == 'access_token');

    if (jwt != null) {
      jwtToken = jwt.value; // 찾은 경우 토큰 값을 설정
    } else {
      // jwtToken이 비었을 경우의 처리 추가
      throw Exception('토큰이 존재하지 않습니다. 로그인이 필요합니다.');
    }

    // 'Bearer' 헤더에 적절한 토큰 값을 설정
    final headers = {
      'Cookie': cookies.map((c) => '${c.name}=${c.value}').join('; '),
      'Authorization': 'Bearer $jwtToken'
    };
    final response =
        await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('555=$data');
      if (data['isSuccess'] && data['result'] != null) {
        return {
          'userName': data['result']['userName'],
          'jobName': data['result']['jobName'],
          'imageUrl': data['result']['imageUrl'] != null &&
                  data['result']['imageUrl'].isNotEmpty
              ? data['result']['imageUrl'][0]['imageUrl']
              : null, // userimageUrl이 null이거나 비어있지 않은 경우 첫 번째 이미지 URL을 가져옵니다. 그렇지 않으면 null을 반환합니다.
        };
      } else {
        throw Exception('Result key is not found in the response');
      }
    } else {
      throw Exception(
          'Failed to load user info. Status code: ${response.statusCode}');
    }
  }

  // 기타 API 호출 메서드들…
}