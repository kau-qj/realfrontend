//api_post.dart
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:realfronted/httpApi/cookie_utils.dart';
import 'package:collection/collection.dart';

class ApiService {
  final baseUrl = 'https://kauqj.shop';
  final endpoint = '/board/posts';

  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };


  // 특정 게시판 게시글 조회
  Future<void> getPosts(String postType) async {
    final uri = Uri.parse(baseUrl);
    final cookies = await cookieJar.loadForRequest(uri);
    String jwtToken = '';
    print('cookies: $cookies');

    // 기존 코드에서 쿠키 이름이 'access_token'인 것을 찾도록 수정
    final jwt = cookies.firstWhereOrNull((cookie) => cookie.name == 'access_token');
    print('jwt: $jwt');
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

    final response = await http.get(
      Uri.parse('$baseUrl/board/postType/$postType'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  // 특정 게시글 상세 조회
  Future<Map<String, dynamic>> getPostDetail(int postIdx) async {
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

    final response = await http.get(
      Uri.parse('$baseUrl/board/posts/$postIdx'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post detail');
    }
  }

  // 게시글 수정
  Future<void> updatePost(int postIdx, String title, String mainText) async {
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
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.patch(
      Uri.parse('$baseUrl/board/posts/$postIdx'),
      headers: headers,
      body: jsonEncode(<String, String>{
        'Title': title,
        'mainText': mainText,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update post');
    }
  }

  // 게시글 삭제
  Future<void> deletePost(int postIdx) async {
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

    final response = await http.delete(
      Uri.parse('$baseUrl/board/posts/$postIdx'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete post');
    }
  }

  // 게시글 작성
  Future<void> createPost(String title, String mainText, int postType) async {
    final uri = Uri.parse(baseUrl);
    final cookies = await cookieJar.loadForRequest(uri);
    String jwtToken = '';

    // 기존 코드에서 쿠키 이름이 'access_token'인 것을 찾도록 수정
    final jwt = cookies.firstWhereOrNull((cookie) => cookie.name == 'access_token');
    print('jwt: $jwt');
    print('cookies: $cookies');

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
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: headers,
      body: jsonEncode(<String, String>{
        'Title': title,
        'mainText': mainText,
        'postType': postType.toString(),
      }),
    );
    print('Title: $title');
    print('mainText: $mainText');
    print('postType: ${postType.toString()}');
    print(response.body);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create post');
    }
  }

  // 댓글 작성
  Future<void> createComment(int postIdx, String contents) async {
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
      'accept': 'application/json',
      'Content-Type': 'application/json; charset=UTF-8',
    };

    final response = await http.post(
      Uri.parse('$baseUrl/board/posts/$postIdx/comments'),
      headers: headers,
      body: jsonEncode(<String, String>{
        'contents': contents,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create comment');
    }
  }

  // 댓글 삭제
  Future<void> deleteComment(int postIdx, int commentIdx) async {
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

    final response = await http.delete(
      Uri.parse('$baseUrl/board/posts/$postIdx/comments/$commentIdx'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to delete comment');
    }
  }
}