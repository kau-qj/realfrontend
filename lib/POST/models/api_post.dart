// api_postboard.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> PostBoard(String postName, String title, String mainText, String postType) async {
  try {
    final baseUrl = "https://kauqj.shop";
    final endpoint = "/app/posts";

    final response = await http.post(
      Uri.parse(baseUrl + endpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'postName': postName, //게시판 종류 ex) 자유, 동아리
        'title': title, //제목
        'mainText': mainText, //내용
        'postType': postType, //어느 게시판인지???
      }),
    );

    if (response.statusCode == 200) {
      print("good");
      return '성공';
    } else {
      return '실패';
    }
  } catch (e) {
    print('PostBoard 함수에서 에러 발생: $e');
    return '에러 발생';
  }
}
