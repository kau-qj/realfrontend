//post_detail.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qj_projec/httpApi/POST/api_service.dart';
import 'package:qj_projec/POST/post.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetailsPage extends StatefulWidget {
  final String postTitle;
  final String postContent;
  final String createAT;
  final VoidCallback onDelete;
  final String nickName;
  final String selectedBoardName;
  final int postId; // 게시글 ID 추가

  const PostDetailsPage({
    Key? key,
    required this.postTitle,
    required this.postContent,
    required this.createAT,
    required this.nickName,
    required this.onDelete,
    required this.selectedBoardName,
    required this.postId, // 생성자에 postId 추가
  }) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final ApiService apiService = ApiService();
  late String mutablePostTitle;
  late String mutablePostContent;
  late TextEditingController commentController;

  @override
  void initState() {
    super.initState();
    mutablePostTitle = widget.postTitle;
    mutablePostContent = widget.postContent;
    commentController = TextEditingController();
    _loadPostDetail(); // 게시글 상세 정보 로드
  }

  Future<void> _loadPostDetail() async {
  try {
    print('Getting details for post: ${widget.postId}'); // 현재 postId 확인 로그
    final postDetail = await apiService.getPostDetail(widget.postId);
    if (postDetail != null && postDetail.isNotEmpty) {
      setState(() {
        mutablePostTitle = postDetail['title'] as String? ?? '기본 제목';
        mutablePostContent = postDetail['content'] as String? ?? '기본 내용';
      });
    } else {
      // 데이터가 비어있거나 null인 경우 처리
      print('No data available for post: ${widget.postId}');
    }
  } catch (e) {
    print('Error loading post detail: $e');
    // 적절한 예외 처리를 여기에 추가합니다.
  }
}


  Future<void> _editPost() async {
    print('Editing post: ${widget.postTitle}');

    try {
      await apiService.updatePost(
        widget.postId,
        mutablePostTitle,
        mutablePostContent,
      );
      print('Post updated successfully');

      _showEditDialog();
    } catch (e) {
      print('Failed to update post: $e');
    }
  }

  Future<void> _deletePost() async {
    print('Deleting post: ${widget.postTitle}');

    try {
      await apiService.deletePost(widget.postId);
      print('Post deleted successfully');

      widget.onDelete();

      Navigator.pop(context);
    } catch (e) {
      print('Failed to delete post: $e');
    }
  }

  Future<void> _showEditDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditPostDialog(
          currentTitle: mutablePostTitle,
          currentContent: mutablePostContent,
          onUpdate: (String title, String content) {
            setState(() {
              mutablePostTitle = title;
              mutablePostContent = content;
            });
          },
        );
      },
    );
  }

  void _addComment() {
    String commentText = commentController.text;
    print('Comment added: $commentText');
    commentController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          '${widget.selectedBoardName}게시판 - 게시글',
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
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.person, size: 20.0, color: Colors.grey),
                    SizedBox(width: 5.0),
                    Text(
                      '작성자: ${widget.nickName}',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
                Text(
                  widget.createAT,
                  style: TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              mutablePostTitle,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                //decoration: TextDecoration.underline,
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              height: 300.0,
              width: double.infinity,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromRGBO(161, 196, 253, 1),
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: SingleChildScrollView(
                child: Text(
                  mutablePostContent,
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      labelText: '댓글을 입력하세요',
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(161, 196, 253, 1),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromRGBO(161, 196, 253, 1),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                ElevatedButton(
                  onPressed: _addComment,
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(161, 196, 253, 1),
                  ),
                  child: Icon(Icons.send),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EditPostDialog extends StatefulWidget {
  final String currentTitle;
  final String currentContent;
  final Function(String, String) onUpdate;

  const EditPostDialog({
    Key? key,
    required this.currentTitle,
    required this.currentContent,
    required this.onUpdate,
  }) : super(key: key);

  @override
  _EditPostDialogState createState() => _EditPostDialogState();
}

class _EditPostDialogState extends State<EditPostDialog> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.currentTitle);
    contentController = TextEditingController(text: widget.currentContent);
  }

  Future<void> _updatePost() async {
    try {
      await ApiService().updatePost(
        1, // Replace with the actual postId
        titleController.text,
        contentController.text,
      );
      print('Post updated successfully');

      setState(() {
        widget.onUpdate(titleController.text, contentController.text);
      });

      Navigator.pop(context);
    } catch (e) {
      print('Failed to update post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('게시글 수정'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              labelText: '제목',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: contentController,
            maxLines: null,
            decoration: InputDecoration(
              labelText: '내용',
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(161, 196, 253, 1)),
              ),
              contentPadding: EdgeInsets.only(top: 10, ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('취소'),
        ),
        ElevatedButton(
          onPressed: _updatePost,
          style: ElevatedButton.styleFrom(
            primary: Color.fromRGBO(161, 196, 253, 1),
          ),
          child: Text('수정 완료'),
        ),
      ],
    );
  }
}