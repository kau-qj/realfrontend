import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';
import 'package:collection/collection.dart';
import 'package:qj_projec/httpApi/cookie_utils.dart';

class ApiService {
  final String baseUrl = 'https://kauqj.shop';

  // 사용자 정보를 가져오는 메서드
  Future<Map<String, dynamic>> fetchData() async {
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
          'imageUrl': parsedImageUrl ?? '기본 이미지 URL',
        };
      } else {
        throw Exception('Result key is not found in the response');
      }
    } else {
      throw Exception(
          'Failed to load user profile. Status code: ${response.statusCode}');
    }
  }

  // 기타 API 호출 메서드들…
}
