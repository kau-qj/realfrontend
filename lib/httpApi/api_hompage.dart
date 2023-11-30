import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cookie_jar/cookie_jar.dart';

// 외부에서 생성된 cookieJar 인스턴스를 사용
final CookieJar cookieJar = CookieJar();

Future<String> fetchData() async {
  final uri = Uri.parse('https://kauqj.shop');
  final cookies = await cookieJar.loadForRequest(uri);
  print("cookies: $cookies");
  final headers = {'Cookie': cookies.map((c) => '${c.name}=${c.value}').join('; ')};

  final response = await http.get(uri, headers: headers);

  if (response.statusCode == 200) {
    // 응답 처리
    return response.body;
  } else {
    throw Exception('요청 실패');
  }
}

class ApiService {
  final String baseUrl = 'https://kauqj.shop';
  final String endpoint = '/home/recruit';

  Future<Map<String, dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to load data. Status code: ${response.statusCode}, Message: ${response.body}');
    }
  }
}