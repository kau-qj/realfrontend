import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../httpApi/api_post.dart';

// 글을 작성하는 화면을 정의하는 StatefulWidget
class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

// CreatePostPage의 State 클래스
class _CreatePostPageState extends State<CreatePostPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final apiService = ApiService();
  
  @override
  void dispose() {
    // 컨트롤러를 사용한 후에는 dispose를 호출해야 합니다.
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
              height: 50,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: '제목',
                ),
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            // 내용 입력 필드
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
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: contentController,
                    decoration: InputDecoration(
                      labelText: '내용을 입력해주세요',
                    ),
                    style: TextStyle(fontSize: 16.0),
                    maxLines: null, // 여러 줄 입력을 허용합니다.
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            // 작성 완료 버튼
            ElevatedButton(
              onPressed: () async {
                final title = titleController.text;
                final content = contentController.text;
                try {
                  await apiService.createPost(title, content, 2); // 숫자 0 대신 postType
                  // 성공적으로 저장한 후 다른 동작 수행 (예: 화면 이동)
                  Navigator.pop(context);
                } catch (e) {
                  // 저장에 실패한 경우 처리 (예: 에러 메시지 표시)
                  print('게시글 작성에 실패했습니다: $e');
                }
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
  const PostDetailsPage({Key? key}) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

// PostDetailsPage의 State 클래스
class _PostDetailsPageState extends State<PostDetailsPage> {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목 입력 필드
            
            const SizedBox(height: 20.0),
            // 댓글 입력 필드
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
            // 댓글 목록
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
  // ListView를 생성하는 메서드
  Widget _buildListView() {
    return ListView.builder(
      itemCount: 0,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 2.0,
          child: ListTile(
            onTap: () {},
            title: Text(
              '제목',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text('내용'),
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