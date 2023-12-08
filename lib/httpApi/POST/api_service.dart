// api_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

// api_service.dart
final baseUrl = 'https://kauqj.shop';  // 기본 URL이 서버 API의 올바른 주소인지 확인
final endpoint = '/board/posts';       // 게시물을 가져오기 위한 올바른 엔드포인트인지 확인


class ApiService {
  Future<void> createPost(String title, String content, int userId) async {
    print('Creating post: $title, $content, $userId');
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> updatePost(int postId, String newTitle, String newContent) async {
    print('Updating post: $postId, $newTitle, $newContent');
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> deletePost(int postId) async {
    print('Deleting post: $postId');
    await Future.delayed(Duration(seconds: 1));
  }

  Future<List<Map<String, dynamic>>> getPosts(int postType) async {
    print('Getting posts for post type: $postType');
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/posts/board/$postType'),
        headers: {'accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        final List<Map<String, dynamic>> posts = responseData
            .map<Map<String, dynamic>>((postJson) {
              return Map<String, dynamic>.from(postJson);
            })
            .toList();

        return posts;
      } else {
        print('Failed to load posts. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load posts');
      }
    } catch (e, stackTrace) {
      print('Error fetching posts: $e\n$stackTrace');
      throw e;
    }
  }

  Future<Map<String, dynamic>> getPostDetail(int postId) async {
    print('Getting details for post: $postId');
    await Future.delayed(Duration(seconds: 0));
    return {};
  }

  Future<void> createComment(int postId, String contents) async {
    print('Creating comment for post $postId: $contents');
    await Future.delayed(Duration(seconds: 1));
  }

  Future<void> deleteComment(int postId, int commentId) async {
    print('Deleting comment $commentId for post $postId');
    await Future.delayed(Duration(seconds: 1));
  }
}