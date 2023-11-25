import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://kauqj.shop';

  // 사용자 정보를 가져오는 메서드
  Future<Map<String, dynamic>> fetchUserInfo() async {
    final String endpoint = '/mypage';
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['isSuccess'] && data['result'] != null) {
        return {
          'userName': data['result']['userName'],
          'job': data['result']['job'],
          'imageUrl': data['result']['userimageUrl'][0]
              ['imageUrl'], // 첫 번째 이미지 URL을 가져옵니다.
        };
      } else {
        throw Exception('Result key is not found in the response');
      }
    } else {
      throw Exception(
          'Failed to load user info. Status code: ${response.statusCode}');
    }
  }

  // 기타 API 호출 메서드들...
}