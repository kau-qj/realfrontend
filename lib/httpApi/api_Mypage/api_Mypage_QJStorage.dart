import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // 기본 URL
  final String baseUrl = 'https://kauqj.shop';

  // 특정 setIdx에 대한 코스 세부 정보를 가져오는 메소드
  Future<List<dynamic>> fetchCourseDetails(int setIdx) async {
    final response = await http.get(
      Uri.parse('$baseUrl/mypage/qj/$setIdx'),
      headers: {'accept': 'application/json'},
    );

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
