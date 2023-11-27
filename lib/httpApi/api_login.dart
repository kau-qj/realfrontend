import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qj_projec/home.dart';
import 'package:qj_projec/bottomNav.dart';
import 'package:qj_projec/httpApi/cookie_utils.dart';

Future<String> loginUser(String userId, String userPw, BuildContext context) async {
  final response = await http.post(
    Uri.parse('https://kauqj.shop/app/login'),
    headers: <String, String>{
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'userId': userId,
      'userPw': userPw,
    }),
  );

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final isSuccess = jsonResponse['isSuccess'];
    final message = jsonResponse['message'];

    if (isSuccess) {
      final token = jsonResponse['result']['token'];
      saveTokenToCookie(token); // 토큰을 쿠키에 저장
      
      // 로그인 성공 시 홈 화면으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyButtomNaVBar()),
      );

      return '로그인 성공: $message';
    } else {
      throw Exception('로그인 실패: $message');
    }
  } else {
    throw Exception('로그인 요청 실패');
  }
}
