//api_post.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> APiPost(String postName, String title, String mainText, String postType) async {
  try {
    // 서버의 기본 URL 및 엔드포인트 정의
    final baseUrl = "https://kauqj.shop";
    final endpoint = "/board/posts";

    print("baseUrl : $baseUrl");
    print("endpoint : $endpoint");

    // 서버에 POST 요청 보내기
    final postResponse = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      // 사용자 데이터를 JSON 형식으로 변환
      body: jsonEncode(<String, String>{
        'postName': postName,
        'title': title,
        'mainText': mainText,
        'postType': postType
      }),
    );

    // POST 요청이 성공적으로 이루어졌는지 확인 (상태 코드 200)
    if (postResponse.statusCode == 200) {
      print("POST 요청이 성공하였습니다.");

      // 서버에 GET 요청 보내기
      final getResponse = await http.get(Uri.parse(baseUrl + endpoint));

      // GET 요청이 성공적으로 이루어졌는지 확인 (상태 코드 200)
      if (getResponse.statusCode == 200) {
        print("GET 요청이 성공하였습니다.");
        print(getResponse.body);
        // GET 요청의 응답 데이터 처리
      } else {
        print("GET 요청이 실패하였습니다.");
      }

      // Add PATCH request
      final postIdx = jsonDecode(postResponse.body)['postIdx']; // assuming 'postIdx' is the identifier returned from the server
      final patchResponse = await http.patch(
        Uri.parse('$baseUrl$endpoint/$postIdx'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'title': 'Updated title',
          'mainText': 'Updated mainText',
          // Add other fields to update in the post
        }),
      );

      if (patchResponse.statusCode == 200) {
        print("PATCH 요청이 성공하였습니다.");
      } else {
        print("PATCH 요청이 실패하였습니다.");
      }

      // Add DELETE request
      final deleteResponse = await http.delete(Uri.parse('$baseUrl$endpoint/$postIdx'));

      if (deleteResponse.statusCode == 200) {
        print("DELETE 요청이 성공하였습니다.");
      } else {
        print("DELETE 요청이 실패하였습니다.");
      }

      return '성공';
    } else {
      return '실패';
    }
  } catch (e) {
    print('함수에서 에러 발생: $e');
    return '에러 발생';
  }
}