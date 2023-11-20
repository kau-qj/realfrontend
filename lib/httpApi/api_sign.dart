import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://kauqj.shop'; // 여기에 사용할 API의 기본 URL을 넣으세요.
  final String endpoint = '/app/user'; // API의 엔드포인트

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http
        .get(Uri.parse('$baseUrl$endpoint')); // 여기에 API의 endpoint를 넣으세요.

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}, Message: ${response.body}');
    }
  }
}