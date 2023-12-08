// post.dart
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qj_projec/httpApi/POST/api_post.dart';
import 'package:qj_projec/POST/post_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class CreatePostPage extends StatefulWidget {
  final _PostPageState parent;

  const CreatePostPage({Key? key, required this.parent}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  int selectedPostType = 0; // Default: 자유
  String selectedBoardName = '자유';
  bool _isChecked = false;

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
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 30),
            child: Container(
              height: 50,
              width: 120,
              child: DropdownButtonFormField<int>(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
                  ),
                ),
                items: [
                  DropdownMenuItem<int>(
                    value: 0,
                    child: Text('자유'),
                  ),
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text('채용'),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text('대외활동'),
                  ),
                  DropdownMenuItem<int>(
                    value: 3,
                    child: Text('동아리'),
                  ),
                  DropdownMenuItem<int>(
                    value: 4,
                    child: Text('뉴스'),
                  ),
                ],
                value: selectedPostType,
                onChanged: (int? value) {
                  setState(() {
                    selectedPostType = value ?? 0;
                    switch (selectedPostType) {
                      case 0:
                        selectedBoardName = '자유';
                        break;
                      case 1:
                        selectedBoardName = '채용';
                        break;
                      case 2:
                        selectedBoardName = '대외활동';
                        break;
                      case 3:
                        selectedBoardName = '동아리';
                        break;
                      case 4:
                        selectedBoardName = '뉴스';
                        break;
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 0.0),
        child: Column(
          children: [
            Container(
              height: 50,
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: '제목',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 0.94)),
                  ),
                ),
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 230,
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: contentController,
                    minLines: 10,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: '내용을 입력해주세요',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 0.94)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 0.94)),
                      ),
                    ),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 0.0),
            Row(
              children: <Widget>[
                Text(
                  "익명",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Color.fromRGBO(161, 196, 253, 0.94),
                  value: _isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 100.0),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromRGBO(194, 233, 251, 1),
                    Color.fromRGBO(161, 196, 253, 0.94),
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  final title = titleController.text;
                  final content = contentController.text;

                  if (title.isEmpty) {
                    print('제목을 입력하세요.');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('제목을 입력하세요.'),
                        backgroundColor: Color.fromRGBO(161, 196, 253, 1),
                      ),
                    );
                    return;
                  } else if (content.isEmpty) {
                    print('내용을 입력하세요.');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('내용을 입력하세요.'),
                        backgroundColor: Color.fromRGBO(161, 196, 253, 1),
                      ),
                    );
                    return;
                  } else if (title.isEmpty && content.isEmpty) {
                    print('제목과 내용을 입력하세요.');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('제목과 내용을 입력하세요.'),
                        backgroundColor: Color.fromRGBO(161, 196, 253, 1),
                      ),
                    );
                    return;
                  }

                  final prefs = await SharedPreferences.getInstance();
                  final apiService = ApiService();
                  try {
                    await apiService.createPost(title, content, selectedPostType);
                    widget.parent.addCreatedPost(title, content, selectedPostType, selectedBoardName);
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
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    const EdgeInsets.symmetric(horizontal: 100),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.transparent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with AutomaticKeepAliveClientMixin {
  List<Map<String, dynamic>> createdPosts = [];
  int currentTab = 0;
  String selectedBoardName = '자유';

  void _savePosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> postsJson =
        createdPosts.map((post) => json.encode(post)).toList();
    prefs.setStringList('createdPosts', postsJson);
  }

  void _loadPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? postsJson = prefs.getStringList('createdPosts');
    if (postsJson != null) {
      setState(() {
        createdPosts = postsJson
            .map<Map<String, dynamic>>((postJson) {
              Map<String, dynamic> postMap =
                  Map<String, dynamic>.from(json.decode(postJson));
              return {
                'title': postMap['title'],
                'content': postMap['content'],
                'postType': postMap['postType'],
                'selectedBoardName': postMap['selectedBoardName'],
              };
            })
            .toList()
            .reversed
            .toList();
      });
    }
  }

  void addCreatedPost(
      String title, String content, int postType, String selectedBoardName) {
    setState(() {
      createdPosts.add({
        'title': title,
        'content': content,
        'postType': postType,
        'selectedBoardName': selectedBoardName,
      });
      _savePosts();
      _loadPosts();
    });
  }

  void removePost(String title) {
    setState(() {
      createdPosts.removeWhere((post) => post['title'] == title);
      _savePosts();
    });
  }

  @override
void initState() {
  super.initState();
  print('initState called');
  _loadPosts();
}

  @override
  void dispose() {
    // 페이지가 종료될 때 _loadPosts 다시 호출
    _loadPosts();
    super.dispose();
  }


  @override
  bool get wantKeepAlive => true;

  Widget _buildListViewForPostType(int postType) {
    List<Map<String, dynamic>> postsForType = createdPosts
        .where((post) => post['postType'] == postType)
        .toList()
        .reversed
        .toList();

    return ListView.builder(
      itemCount: postsForType.length,
      itemBuilder: (context, index) {
        final post = postsForType[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          elevation: 10.0,
          shadowColor: Colors.grey,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailsPage(
                    postTitle: post['title'] ?? '',
                    postContent: post['content'] ?? '',
                    createAT: post['time'] ?? '',
                    nickName: post['nickName'] ?? '',
                    selectedBoardName: post['selectedBoardName'] ?? '',
                    onDelete: () async {
                      removePost(post['title'] ?? '');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('게시글이 삭제되었습니다.'),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
            child: Container(
              height: 93.0,
              padding: EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post['title'] ?? '',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    post['content'] ?? '',
                    maxLines: 2,
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
                      borderSide:
                          BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
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
                onTap: (index) {
                  setState(() {
                    currentTab = index;
                  });
                },
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildListViewForPostType(0),
                    _buildListViewForPostType(1),
                    _buildListViewForPostType(2),
                    _buildListViewForPostType(3),
                    _buildListViewForPostType(4),
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