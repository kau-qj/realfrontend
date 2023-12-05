// post.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '게시판 앱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostPage(),
    );
  }
}

class CreatePostPage extends StatefulWidget {
  final _PostPageState parent;

  const CreatePostPage({Key? key, required this.parent}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          '글 쓰기',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        centerTitle: false,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset('assets/BackButton.svg'),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 70,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: '제목',
                ),
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Container(
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      labelText: '내용을 입력해주세요',
                    ),
                    style: TextStyle(fontSize: 16.0),
                    maxLines: null,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 240.0),
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text;
                final content = contentController.text;

                if (title.isEmpty && content.isEmpty) {
                  print('제목과 내용을 입력하세요.');
                  return;
                } else if (title.isEmpty) {
                  print('제목을 입력하세요.');
                  return;
                } else if (content.isEmpty) {
                  print('내용을 입력하세요.');
                  return;
                }

                final prefs = await SharedPreferences.getInstance();
                final apiService = ApiService();

                try {
                  await apiService.createPost(title, content, 2);

                  widget.parent.addCreatedPost(title, content);

                  await prefs.setString('title', title);
                  await prefs.setString('content', content);

                  final storedTitle = prefs.getString('title');
                  final storedContent = prefs.getString('content');
                  print('Stored title: $storedTitle');
                  print('Stored content: $storedContent');

                  Navigator.pop(context);
                } catch (e) {
                  print('게시글 작성에 실패했습니다: $e');
                  if (e is Error) {
                    print('Stack trace: ${e.stackTrace}');
                  }
                }
              },
              child: const Text('작성완료', style: TextStyle(fontSize: 30)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 80),
                backgroundColor: Color.fromRGBO(161, 196, 253, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommentSection extends StatefulWidget {
  const CommentSection({Key? key}) : super(key: key);

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
        TextField(
          decoration: InputDecoration(
            labelText: "댓글을 입력하세요...",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(35),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
              borderRadius: BorderRadius.circular(35),
            ),
            contentPadding: EdgeInsets.all(20),
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              onPressed: () {},
            ),
          ),
        ),
        const SizedBox(height: 20.0),
        Expanded(
          child: ListView.builder(
            itemCount: 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('댓글'),
              );
            },
          ),
        ),
      ],
    );
  }
}

class PostDetailsPage extends StatefulWidget {
  final String postTitle;
  final String postContent;
  final Function onDelete;

  const PostDetailsPage({Key? key, required this.postTitle, required this.postContent, required this.onDelete}) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final ApiService apiService = ApiService();

  Future<void> _editPost() async {
    print('Editing post: ${widget.postTitle}'); // Debugging: Log when editing starts

    try {
      await apiService.updatePost(1, widget.postTitle + ' Updated', widget.postContent + ' Updated');
      print('Post updated successfully'); // Debugging: Log when editing is successful
      // You may want to refresh the UI or navigate back after a successful update
    } catch (e) {
      print('Failed to update post: $e'); // Debugging: Log if editing fails
    }
  }

  Future<void> _deletePost() async {
    print('Deleting post: ${widget.postTitle}'); // Debugging: Log when deletion starts

    try {
      await apiService.deletePost(1);
      print('Post deleted successfully'); // Debugging: Log when deletion is successful

      widget.onDelete();

      // Access the parent widget directly and remove the post
      final PostPage? parentPage = ModalRoute.of(context)?.settings.arguments as PostPage?;

      // Navigate back after a successful deletion
      Navigator.pop(context);
    } catch (e) {
      print('Failed to delete post: $e'); // Debugging: Log if deletion fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          '게시판 - 게시글',
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        centerTitle: false,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: 10),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset('assets/BackButton.svg'),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Color.fromRGBO(161, 196, 253, 1)),
            onPressed: _editPost,
          ),
          IconButton(
            icon: Icon(Icons.delete, color: Color.fromRGBO(161, 196, 253, 1)),
            onPressed: _deletePost,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.postTitle,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15.0),
            Text(
              widget.postContent,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

class ApiService {
  Future<void> createPost(String title, String content, int userId) async {
    // TODO: Implement API call to create a post
    print('Creating post: $title, $content, $userId');
    // Simulating an API call delay
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> updatePost(int postId, String newTitle, String newContent) async {
    // TODO: Implement API call to update a post
    print('Updating post: $postId, $newTitle, $newContent');
    // Simulating an API call delay
    await Future.delayed(Duration(seconds: 2));
  }

  Future<void> deletePost(int postId) async {
    // TODO: Implement API call to delete a post
    print('Deleting post: $postId');
    // Simulating an API call delay
    await Future.delayed(Duration(seconds: 2));
  }
}

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with AutomaticKeepAliveClientMixin {
  List<Map<String, String>> createdPosts = [];

  @override
  void initState() {
    super.initState();
    // 앱이 시작될 때 로컬 저장소에서 게시글을 로드합니다.
    _loadPosts();
  }

  void addCreatedPost(String title, String content) {
    setState(() {
      createdPosts.add({'title': title, 'content': content});
      // 게시글이 추가될 때마다 로컬 저장소에 업데이트합니다.
      _savePosts();
    });
  }

  void removePost(String title) {
    setState(() {
      createdPosts.removeWhere((post) => post['title'] == title);
      // 게시글이 삭제될 때마다 로컬 저장소에 업데이트합니다.
      _savePosts();
    });
  }

  // 로컬 저장소에서 게시글을 로드합니다.
  void _loadPosts() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? postsJson = prefs.getStringList('createdPosts');
  if (postsJson != null) {
    setState(() {
      createdPosts = postsJson.map<Map<String, String>>((postJson) {
        Map<String, dynamic> postMap = json.decode(postJson);
        return {'title': postMap['title'], 'content': postMap['content']};
      }).toList();
    });
  }
}

  // 로컬 저장소에 게시글을 저장합니다.
  void _savePosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> postsJson = createdPosts.map((post) => json.encode(post)).toList();
    prefs.setStringList('createdPosts', postsJson);
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildListView() {
    return ListView.builder(
      itemCount: createdPosts.length,
      itemBuilder: (context, index) {
        final post = createdPosts[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 2.0,
          child: InkWell(
            onTap: () {
              // 상세 게시물 페이지로 이동
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailsPage(
                    postTitle: post['title'] ?? '',
                    postContent: post['content'] ?? '',
                    onDelete: () {
                      // 삭제 시 호출되는 메서드
                      removePost(post['title'] ?? '');
                    },
                  ),
                ),
              );
            },
            child: Container(
              height: 90.0, // 원하는 높이로 설정
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['title'] ?? '',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    post['content'] ?? '',
                    maxLines: 2, // 최대 두 줄까지 표시
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: null,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 80),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {},
                    ),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreatePostPage(parent: this)),
            );
          },
          child: const Icon(Icons.create),
          backgroundColor: Color.fromRGBO(161, 196, 253, 1),
        ),
      ),
    );
  }
}