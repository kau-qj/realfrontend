import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://kauqj.shop'; // 실제 API 주소로 변경

  // 사용자 정보를 가져오는 메서드
  Future<Map<String, dynamic>> fetchUserInfo() async {
    final String endpoint = '/mypage/info'; // 실제 엔드포인트로 변경
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['isSuccess']) {
        return data['result'];
      } else {
        throw Exception('Failed to fetch user info');
      }
    } else {
      throw Exception('Failed to connect to the server');
    }
  }
}
