import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:qj_projec/httpApi/cookie_utils.dart';

class ApiService {
  final String baseUrl = 'https://kauqj.shop'; // API의 기본 URL
  final String endpoint = '/mypage/qj'; // API의 엔드포인트

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: {'accept': 'application/json'}, // 추가된 HTTP 헤더
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      return data['result'][0] as List; // 'result'의 첫 번째 항목 반환
    } else {
      throw Exception('Failed to load data. Status code: ${response.statusCode}, Message: ${response.body}');
    }
  }
}