import 'dart:convert';
import 'package:http/http.dart' as http;

final String baseUrl = 'https://kauqj.shop/app/posts';

Future<void> createPost() async {
  final response = await http.post(
    Uri.parse('$baseUrl/board/posts'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'postName': 'postName',
      'title': 'title',
      'mainText': 'mainText',
      'postType': 'postType',
    }),
  );

  if (response.statusCode == 200) {
    print('게시글 생성 성공: ${response.body}');
  } else {
    print('게시글 생성 실패: ${response.statusCode}');
  }
}

Future<void> getPosts() async {
  final response = await http.get(Uri.parse('$baseUrl/board/posts'));

  if (response.statusCode == 200) {
    print('게시글 조회 성공: ${response.body}');
  } else {
    print('게시글 조회 실패: ${response.statusCode}');
  }
}

Future<void> updatePost(String postId) async {
  final response = await http.patch(
    Uri.parse('$baseUrl/board/posts/$postId'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      'postName': 'updatedName',
      'title': 'updatedTitle',
      'mainText': 'updatedText',
      'postType': 'updatedType',
    }),
  );

  if (response.statusCode == 200) {
    print('게시글 수정 성공: ${response.body}');
  } else {
    print('게시글 수정 실패: ${response.statusCode}');
  }
}

Future<void> deletePost(String postId) async {
  final response = await http.delete(Uri.parse('$baseUrl/board/posts/$postId'));

  if (response.statusCode == 200) {
    print('게시글 삭제 성공: ${response.body}');
  } else {
    print('게시글 삭제 실패: ${response.statusCode}');
  }
}