import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:qj_projec/httpApi/cookie_utils.dart';

class ApiService {
  final String baseUrl = 'https://kauqj.shop';

  Future<Map<String, dynamic>> fetchUserProfile() async {
    final String endpoint = '/mypage/profile';
    try {
      final response = await http.get(
        Uri.parse('$baseUrl$endpoint'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['isSuccess'] && data['result'] != null) {
          return data['result']; // 'result' 키에 해당하는 값을 반환
        } else {
          throw Exception('Result key is not found in the response');
        }
      } else {
        throw Exception('Failed to load user profile. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching user profile: $e');
    }
  }
}