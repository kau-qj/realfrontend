//api_post.dart

import 'package:http/http.dart' as http;
import 'dart:convert';

final baseUrl = 'https://kauqj.shop';
final endpoint = '/board/posts';



Map<String, String> headers = {
  'Content-Type': 'application/json',
};

// 특정 게시판 게시글 조회
Future<void> getPosts(String postType) async {
  final response = await http.get(
    Uri.parse('$baseUrl/board/postType/$postType'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load posts');
  }
}

// 특정 게시글 상세 조회
Future<void> getPostDetail(int postIdx) async {
  final response = await http.get(
    Uri.parse('$baseUrl/board/posts/$postIdx'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load post detail');
  }
}

// 게시글 수정
Future<void> updatePost(int postIdx, String title, String mainText) async {
  final response = await http.patch(
    Uri.parse('$baseUrl/board/posts/$postIdx'),
    headers: headers,
    body: jsonEncode(<String, String>{
      'Title': title,
      'mainText': mainText,
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update post');
  }
}

// 게시글 삭제
Future<void> deletePost(int postIdx) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/board/posts/$postIdx'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  } else {
    throw Exception('Failed to delete post');
  }
}

// 게시글 작성
Future<void> createPost(String title, String mainText, int postType) async {
  final response = await http.post(
    Uri.parse('$baseUrl/board/posts'),
    headers: headers,
    body: jsonEncode(<String, String>{
      'Title': title,
      'mainText': mainText,
      'postType': postType.toString(),
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create post');
  }
}

// 댓글 작성
Future<void> createComment(int postIdx, String contents) async {
  final response = await http.post(
    Uri.parse('$baseUrl/board/posts/$postIdx/comments'),
    headers: headers,
    body: jsonEncode(<String, String>{
      'contents': contents,
    }),
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create comment');
  }
}

// 댓글 삭제
Future<void> deleteComment(int postIdx, int commentIdx) async {
  final response = await http.delete(
    Uri.parse('$baseUrl/board/posts/$postIdx/comments/$commentIdx'),
    headers: headers,
  );

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
  } else {
    throw Exception('Failed to delete comment');
  }
}
