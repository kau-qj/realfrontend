import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class Post {
  final String title;
  final String content;

  Post(this.title, this.content);
}

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

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

  Widget _buildListView() {
    return ListView.builder(
      itemCount: _filteredPosts.length,
      itemBuilder: (context, index) {
        final post = _filteredPosts[index];
        return ListTile(
          title: Text(post.title),
          subtitle: Text(post.content),
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
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search...',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _searchController.clear(),
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
                      borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),  // 포커스를 가질 때의 테두리 색상
                    ),
                  ),
                ),
              ),
              TabBar(
                labelColor: Color.fromRGBO(161, 196, 253, 1), // 선택된 Tab의 색상을 변경합니다.
                unselectedLabelColor: Colors.black,
                labelStyle: TextStyle(fontSize: 12.0),
                indicatorColor: Color.fromRGBO(161, 196, 253, 1),
                tabs: [
                  Tab(
                    text: '자유',
                  ),
                  Tab(
                    text: '채용',
                  ),
                  Tab(
                    text: '대외활동',
                  ),
                  Tab(
                    text: '동아리',
                  ),
                  Tab(
                    text: '뉴스',
                  ),
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

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('글 쓰기',
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
              height: 50,
              
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: '제목',
                  
                  border: UnderlineInputBorder(), // 선의 형태로 변경
                  focusedBorder: UnderlineInputBorder( // 선택했을 때 테두리 색상을 빨간색으로 변경
                    borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
                  ),
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _contentController,
                  maxLines: 5,
                  minLines: 5,
                  decoration: InputDecoration(
                    labelText: '내용을 입력하세요.',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder( // 선택했을 때 테두리 색상을 빨간색으로 변경
                      borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: EdgeInsets.all(50),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 0.0),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () {
                  // TODO: Save the post
                },
                child: Container(
                  color: Colors.white, // 배경색을 파란색으로 설정
                  child: SvgPicture.asset('assets/writeFinish.svg'),
                ),
              ),
            ),

            /*
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Save the post
                },
                child: const Text('작성완료', style: TextStyle(fontSize: 20)),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 80),
                  backgroundColor: Color.fromRGBO(194, 233, 251, 0.944),
                ),
              ),
            ),
            */
          ],
        ),
      ),
    );
  }
}