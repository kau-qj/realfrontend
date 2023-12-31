import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:collection/collection.dart';
import 'package:qj_projec/httpApi/cookie_utils.dart';


class ApiService {
  final String baseUrl = 'https://kauqj.shop'; // 여기에 사용할 API의 기본 URL을 넣으세요.
  //final String endpoint = '/jobguide/jobdetails/{jobname}'; // API의 엔드포인트

  Future<Map<String, dynamic>> fetchData(String jobname) async {
    final String endpoint = '/jobguide/jobdetails/$jobname'; // API의 엔드포인트
    final uri = Uri.parse(baseUrl);
    final cookies = await cookieJar.loadForRequest(uri);
    String jwtToken = '';
    // 기존 코드에서 쿠키 이름이 'access_token'인 것을 찾도록 수정
    final jwt = cookies.firstWhereOrNull((cookie) => cookie.name == 'access_token');

    if (jwt != null) {
      jwtToken = jwt.value;  // 찾은 경우 토큰 값을 설정
    } else {
      // jwtToken이 비었을 경우의 처리 추가
      throw Exception('토큰이 존재하지 않습니다. 로그인이 필요합니다.');
    }

    // 'Bearer' 헤더에 적절한 토큰 값을 설정
    final headers = {
      'Cookie': cookies.map((c) => '${c.name}=${c.value}').join('; '),
      'Authorization': 'Bearer $jwtToken'
    };

    final response = await http.get(Uri.parse('$baseUrl$endpoint'), headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
        'Failed to load data. Status code: ${response.statusCode}, Message: ${response.body}');
    }
  }

  //관심직무추가 또는 수정
  Future<Map<String, dynamic>> fetchInterestJob(String jobName) async {
    final String endpoint = '/jobguide/interestjob'; // API의 엔드포인트
    final uri = Uri.parse(baseUrl);
    final cookies = await cookieJar.loadForRequest(uri);
    String jwtToken = '';
    // 기존 코드에서 쿠키 이름이 'access_token'인 것을 찾도록 수정
    final jwt = cookies.firstWhereOrNull((cookie) => cookie.name == 'access_token');

    if (jwt != null) {
      jwtToken = jwt.value;  // 찾은 경우 토큰 값을 설정
    } else {
      // jwtToken이 비었을 경우의 처리 추가
      throw Exception('토큰이 존재하지 않습니다. 로그인이 필요합니다.');
    }

    // 'Bearer' 헤더에 적절한 토큰 값을 설정
    final headers = {
      'Cookie': cookies.map((c) => '${c.name}=${c.value}').join('; '),
      'Authorization': 'Bearer $jwtToken',
      'Content-Type': 'application/json',  // Content-Type 헤더 추가
    };

    final response = await http.put(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: json.encode({'jobName': jobName}),  // 요청 본문에 jobName 포함
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
        'Failed to load data. Status code: ${response.statusCode}, Message: ${response.body}');
    }
  }

}