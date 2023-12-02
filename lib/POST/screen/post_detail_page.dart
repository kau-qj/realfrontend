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
            color: Color.fromRGBO(161, 196, 253, 1),
          ),
          // 삭제 버튼
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deletePost(context);
            },
            color: Color.fromRGBO(161, 196, 253, 1),
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
            // 내용
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
            const SizedBox(height: 20.0),

            // 댓글 목록
            Expanded(
            child: ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 100,
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 6),
                              Icon(Icons.account_circle, color: Color.fromRGBO(161, 196, 253, 1)),
                              SizedBox(width: 8),
                              Text(
                                "작성자",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(161, 196, 253, 1),
                                ),
                              ),
                              Spacer(),
                              Container(
                                height: 18,
                                child: IconButton(
                                  icon: Icon(Icons.delete, color: Color.fromRGBO(161, 196, 253, 1)),
                                  onPressed: () {
                                    _deleteComment(index);
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            _comments[_comments.length - index - 1],
                            style: TextStyle(fontSize: 14),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "작성 시간",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

            const SizedBox(height: 20.0),
            // 댓글 입력 필드
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: "댓글을 입력하세요...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      contentPadding: EdgeInsets.all(13.5),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Color.fromRGBO(161, 196, 253, 1)),
                  onPressed: () {
                    _addComment();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editPost(BuildContext context) {
    // 수정 기능 추가
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => EditPostPage(post: widget.post),
    //   ),
    // );
  }

  void _deletePost(BuildContext context) {
    // 삭제 기능 추가
    // Navigator.pop(context);
  }

  void _addComment() {
    setState(() {
      _comments.insert(0, _commentController.text);
      _commentController.clear();
    });
  }

  void _deleteComment(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("댓글 삭제"),
          content: Text("정말로 이 댓글을 삭제하시겠습니까?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("취소"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _comments.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: Text("삭제"),
            ),
          ],
        );
      },
    );
  }
}