// post_page.dart

import 'package:flutter/material.dart';
import 'package:qj_projec/POST/screen/post_detail_page.dart';
import 'create_post_page.dart';
import '../models/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  // 컨트롤러와 게시글 리스트를 초기화합니다.
  final TextEditingController _searchController = TextEditingController();
  final List<Post> _posts = List<Post>.generate(
    50,
    (index) => Post('글 제목 #$index', '글 내용입니다. #$index'),
  );

  // 검색 결과를 담을 리스트를 초기화합니다.
  List<Post> _filteredPosts = [];

  @override
  void initState() {
    super.initState();
    _filteredPosts = _posts;
    _searchController.addListener(_filterPosts);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterPosts);
    _searchController.dispose();
    super.dispose();
  }

  // 검색어에 따라 게시글을 필터링하는 메서드를 정의합니다.
  void _filterPosts() {
    final query = _searchController.text;

    if (query.trim().isEmpty) {
      setState(() => _filteredPosts = _posts);
    } else {
      final filteredPosts = _posts.where((post) {
        return post.title.contains(query.trim()) ||
            post.content.contains(query.trim());
      }).toList();
      setState(() => _filteredPosts = filteredPosts);
    }
  }

  // 게시글 목록을 보여주는 리스트뷰를 생성하는 메서드입니다.
  Widget _buildListView() {
    return ListView.builder(
      itemCount: _filteredPosts.length,
      itemBuilder: (context, index) {
        final post = _filteredPosts[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 2.0,
          child: ListTile(
            onTap: () {
              // 게시글 상세 페이지로 이동합니다.
              _navigateToPostDetails('자유', post);
            },
            title: Text(
              post.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(post.content),
          ),
        );
      },
    );
  }

  // 게시글 상세 페이지로 이동하는 메서드입니다.
  void _navigateToPostDetails(String boardName, Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailsPage(boardName: boardName, post: post),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: null, // 앱바를 사용하지 않도록 설정
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 80),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        _filterPosts();
                      },
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: _filterPosts,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
                    ),
                  ),
                ),
              ),
              TabBar(
                labelColor: Color.fromRGBO(161, 196, 253, 1),
                unselectedLabelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 12.0),
                indicatorColor: Color.fromRGBO(161, 196, 253, 1),
                tabs: [
                  Tab(text: '자유'),
                  Tab(text: '채용'),
                  Tab(text: '대외활동'),
                  Tab(text: '동아리'),
                  Tab(text: '뉴스'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildListView(),
                    _buildListView(),
                    _buildListView(),
                    _buildListView(),
                    _buildListView(),
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // 글 작성 페이지로 이동합니다.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreatePostPage()),
            );
          },
          child: const Icon(Icons.create),
          backgroundColor: Color.fromRGBO(161, 196, 253, 1),
        ),
      ),
    );
  }
}
