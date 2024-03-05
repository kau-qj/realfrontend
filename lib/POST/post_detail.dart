import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qj_projec/httpApi/POST/api_service.dart';

class Comment {
  final int commentId; // 댓글 ID
  final String text;
  final String userName;

  Comment({required this.commentId, required this.text, required this.userName});
}

class PostDetailsPage extends StatefulWidget {
  final String postTitle;
  final String postContent;
  final String createAT;
  final VoidCallback onDelete;
  final String nickName;
  final String selectedBoardName;
  final int postId;

  const PostDetailsPage({
    Key? key,
    required this.postTitle,
    required this.postContent,
    required this.createAT,
    required this.nickName,
    required this.onDelete,
    required this.selectedBoardName,
    required this.postId,
  }) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  final ApiService apiService = ApiService();
  late String mutablePostTitle;
  late String mutablePostContent;
  late TextEditingController commentController;
  List<Comment> comments = [];

  @override
  void initState() {
    super.initState();
    mutablePostTitle = widget.postTitle;
    mutablePostContent = widget.postContent;
    commentController = TextEditingController();
    _loadPostDetail();
    _loadComments();
  }

  Future<void> _loadPostDetail() async {
    try {
      print('Getting details for post: ${widget.postId}');
      final postDetail = await apiService.getPostDetail(widget.postId);
      if (postDetail != null && postDetail.isNotEmpty) {
        setState(() {
          mutablePostTitle = postDetail['title'] as String? ?? '기본 제목';
          mutablePostContent = postDetail['content'] as String? ?? '기본 내용';
        });
      } else {
        print('No data available for post: ${widget.postId}');
      }
    } catch (e) {
      print('Error loading post detail: $e');
    }
  }

  Future<void> _loadComments() async {
    // TODO: Implement loading comments from the server.
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

  Future<void> _addComment() async {
    String commentText = commentController.text;
    String userName = '사용자'; // TODO: Modify as needed based on user information

    // TODO: Implement API call to add a new comment and get the comment ID.
    int commentId = 1; // Replace with the actual comment ID.

    Comment newComment = Comment(commentId: commentId, text: commentText, userName: userName);

    setState(() {
      comments.add(newComment);
    });

    print('Comment added: $commentText');
    commentController.clear();
  }

  Future<void> _deleteComment(int index) async {
    // TODO: Implement API call to delete a comment.
    // 예를 들어, comments[index].commentId와 같은 방식으로 삭제할 수 있습니다.

    setState(() {
      comments.removeAt(index);
    });

    print('Comment deleted successfully');
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
                      '작성자: 마하',
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
            const SizedBox(height: 30.0),
            Text(
              '댓글',
              style: TextStyle(
                fontSize: 20.0,
                //fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: comments.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text(comments[index].text),
                            subtitle: Text('작성자: 마하'),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Color.fromRGBO(161, 196, 253, 1)),
                          onPressed: () {
                            _deleteComment(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
              contentPadding: EdgeInsets.only(top: 10),
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