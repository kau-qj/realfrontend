// create_post_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  // 컨트롤러를 통해 제목과 내용을 입력 받습니다.
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), // 앱 바를 생성하는 메서드 호출
      body: _buildBody(), // 본문을 생성하는 메서드 호출
    );
  }

  // 앱 바를 생성하는 메서드
  AppBar _buildAppBar() {
    return AppBar(
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
    );
  }

  // 본문을 생성하는 메서드
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          _buildTitleInput(),    // 제목 입력 필드
          const SizedBox(height: 15.0),
          _buildContentInput(),  // 내용 입력 필드
          const SizedBox(height: 150.0),
          _buildSubmitButton(),   // 작성 완료 버튼
        ],
      ),
    );
  }

  // 제목을 입력하는 필드를 생성하는 메서드
  Widget _buildTitleInput() {
    return Container(
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
    );
  }

  // 내용을 입력하는 필드를 생성하는 메서드
  Widget _buildContentInput() {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: _contentController,
          maxLines: 15,
          minLines: 10,
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
    );
  }

  // 작성 완료 버튼을 생성하는 메서드
  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        _savePost();  // 작성 완료 버튼 클릭 시 글을 저장하는 메서드 호출
        Navigator.pop(context);  // 현재 페이지를 닫고 이전 페이지로 이동
      },
      child: const Text(
        '작성완료',
        style: TextStyle(fontSize: 35, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 90),
        backgroundColor: Color.fromRGBO(161, 196, 253, 1),
      ),
    );
  }

  // 작성 완료 버튼 클릭 시 호출되는 메서드 (아직 미구현)
  void _savePost() {
    // TODO: Save the post logic
  }
}