import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://kauqj.shop'; // 여기에 사용할 API의 기본 URL을 넣으세요.
  final String endpoint = '/qj/newJob'; // API의 엔드포인트
  
  Future<Map<String, dynamic>> sendJob(String job) async {
    final response = await http.post(Uri.parse('$baseUrl$endpoint'),
      headers: {'Content-Type': 'application/json'},  // JSON 형식으로 보낼 것임을 명시
      body: json.encode({'job': job}),  // job을 JSON 형식으로 인코딩하여 보냄
    );
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to send job. Status code: ${response.statusCode}, Message: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http
      .get(Uri.parse('$baseUrl$endpoint')); // API 엔드포인트를 추가해주세요

    if (response.statusCode == 200) {
      return json.decode(response.body);  // 응답 본문을 JSON으로 디코딩
    } else {
      throw Exception('Failed to load data');  // 요청 실패 시 예외 발생
    }
  }

}