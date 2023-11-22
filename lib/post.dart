import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// 글의 데이터 모델을 정의하는 클래스
class Post {
  final String title;
  final String content;

  Post(this.title, this.content);
}

// 글을 작성하는 화면을 정의하는 StatefulWidget
class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

// CreatePostPage의 State 클래스
class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

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
            // 제목을 입력하는 부분
            Container(
              height: 50,
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: '제목',
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            // 내용을 입력하는 부분
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _contentController,
                  maxLines: 10,
                  minLines: 5,
                  decoration: InputDecoration(
                    labelText: '내용을 입력하세요.',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: EdgeInsets.all(20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            // 작성 완료 버튼
            ElevatedButton(
              onPressed: () {
                // TODO: Save the post
                Navigator.pop(context);
              },
              child: const Text('작성완료', style: TextStyle(fontSize: 20)),
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

// 글의 세부 정보와 댓글을 표시하는 화면을 정의하는 StatefulWidget
class PostDetailsPage extends StatefulWidget {
  final String boardName;
  final Post post;

  const PostDetailsPage({Key? key, required this.boardName, required this.post}) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

// PostDetailsPage의 State 클래스
class _PostDetailsPageState extends State<PostDetailsPage> {
  List<String> _comments = [];
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          '${widget.boardName} 게시판 - ${widget.post.title}',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 글의 제목을 표시하는 부분
            Container(
              height: 50,
              child: Text(
                widget.post.title,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline
                ),
              ),
            ),
            const SizedBox(height: 15.0),
           // 글의 내용을 표시하는 부분
          Container(
            height: 300, // 필요에 따라 높이 조절
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
              padding: const EdgeInsets.all(120.0),
              child: SingleChildScrollView(
                child: Text(
                  widget.post.content,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),

            const SizedBox(height: 238.0),
            // 댓글을 입력하는 부분
            TextField(
              controller: _commentController,
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
                  onPressed: () {
                    setState(() {
                      _comments.add(_commentController.text);
                      _commentController.clear();
                    });
                  },
                ),
              ),
            ),
           
            const SizedBox(height: 20.0),
            // 댓글 목록을 나타내는 ListView
            Expanded(
              child: ListView.builder(
                itemCount: _comments.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_comments[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 전체 게시판을 나타내는 StatefulWidget
class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

// PostPage의 State 클래스
class _PostPageState extends State<PostPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Post> _posts = List<Post>.generate(
    50,
    (index) => Post('Post #$index', 'Content for Post #$index'),
  );

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

  // 게시글을 검색하는 메서드
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

  // 글의 세부 정보 페이지로 이동하는 메서드
  void _navigateToPostDetails(String boardName, Post post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostDetailsPage(boardName: boardName, post: post),
      ),
    );
  }

  // ListView를 생성하는 메서드
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: null, // 앱 바를 사용하지 않음
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 80),
              // 검색 기능을 제공하는 TextField
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
              // 각 카테고리를 표시하는 TabBar
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
              // 각 카테고리에 따른 게시글 목록을 표시하는 TabBarView
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
        // 글 작성 화면으로 이동하는 FloatingActionButton
        floatingActionButton: FloatingActionButton(
          onPressed: () {
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