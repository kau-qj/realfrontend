// post_details_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/post.dart';

class PostDetailsPage extends StatefulWidget {
  final String boardName;
  final Post post;

  const PostDetailsPage({Key? key, required this.boardName, required this.post}) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  // 댓글을 저장할 리스트와 댓글 입력 필드 컨트롤러를 정의합니다.
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
        actions: [
          // 수정 버튼
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _editPost(context);
            },
            color: Color.fromRGBO(161, 196, 253, 1), // 아이콘 색상 설정
          ),
          // 삭제 버튼
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deletePost(context);
            },
            color: Color.fromRGBO(161, 196, 253, 1), // 아이콘 색상 설정
          ),
        ],
      ),
       body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 제목
            Container(
              height: 60,
              child: Text(
                widget.post.title,
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            //내용
            const SizedBox(height: 15.0),
            Container(
              height: 280,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
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
                  child: Text(
                    widget.post.content,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50.0),
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
                contentPadding: EdgeInsets.all(22),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: Color.fromRGBO(161, 196, 253, 1)),
                  onPressed: () {
                    // 댓글을 리스트에 추가하고 입력 필드를 초기화합니다.
                    setState(() {
                      _comments.add(_commentController.text);
                      _commentController.clear();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0),
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

  // 글 수정 기능을 수행하는 메서드 (미구현)
  void _editPost(BuildContext context) {
    // TODO: 글 수정 기능을 수행하는 코드를 추가하세요.
    // 수정 화면으로 이동하도록 할 수 있습니다.
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => EditPostPage(post: widget.post),
    //   ),
    // );
  }

  // 글 삭제 기능을 수행하는 메서드 (미구현)
  void _deletePost(BuildContext context) {
    // TODO: 글 삭제 기능을 수행하는 코드를 추가하세요.
    // 글을 삭제한 후 이전 화면으로 돌아갈 수 있습니다.
    // Navigator.pop(context);
  }
}
