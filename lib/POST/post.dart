// post.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'api_post.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreatePostPage extends StatefulWidget {
  final _PostPageState parent;

  const CreatePostPage({Key? key, required this.parent}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final apiService = ApiService();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

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
                try {
                  await apiService.createPost(title, content, 2);

                  widget.parent.addCreatedPost(title, content);

                  final prefs = await SharedPreferences.getInstance();
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
                if (title.isEmpty && content.isEmpty) {
                  print('제목과 내용을 입력하세요.');
                } else if (title.isEmpty) {
                  print('제목을 입력하세요.');
                } else if (content.isEmpty) {
                  print('내용을 입력하세요.');
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

class _PostDetailsPageState extends State<StatefulWidget> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final apiService = ApiService();

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
            onTap: () {},
            child: SvgPicture.asset('assets/BackButton.svg'),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CommentSection(),
      ),
    );
  }
}

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Map<String, String>> createdPosts = [];

  void addCreatedPost(String title, String content) {
    setState(() {
      createdPosts.add({'title': title, 'content': content});
    });
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: createdPosts.length,
      itemBuilder: (context, index) {
        final post = createdPosts[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 2.0,
          child: ListTile(
            onTap: () {
              // TODO: Navigate to detailed post page
            },
            title: Text(
              post['title'] ?? '',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(post['content'] ?? ''),
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
