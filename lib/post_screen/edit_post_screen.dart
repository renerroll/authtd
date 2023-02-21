import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../cubit/edit_post_cubit.dart';
import '../data/models/posts.dart';

class EditPostScreen extends StatelessWidget {
  final Post post;
  EditPostScreen({super.key, required this.post});

  final _controller = TextEditingController();
  final _bodycontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controller.text = post.title;
    _bodycontroller.text = post.body;

    return BlocListener<EditPostCubit, EditPostState>(
      listener: (context, state) {
        if (state is PostEdited) {
          Navigator.pop(context);
        } else if (state is EditPostError) {
          Toast.show(state.error,
              backgroundColor: Colors.red, duration: 1, gravity: Toast.center);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Редагувати Пост"),
          actions: [
            InkWell(
              onTap: () {
                BlocProvider.of<EditPostCubit>(context).deletePost(post);
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.delete),
              ),
            )
          ],
        ),
        body: _body(context),
      ),
    );
  }

  Widget _body(context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            autocorrect: true,
            decoration: InputDecoration(hintText: "Введення повідомлення..."),
          ),
          SizedBox(height: 10.0),
          TextField(
            autofocus: false,
            controller: _bodycontroller,
            decoration: InputDecoration(
                hintText: "Введіть основний текст повідомлення..."),
          ),
          SizedBox(height: 10.0),
          InkWell(
              onTap: () {
                BlocProvider.of<EditPostCubit>(context)
                    .updatePost(post, _controller.text, _bodycontroller.text);
              },
              child: _updateBtn(context))
        ],
      ),
    );
  }

  Widget _updateBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          "Змінити пост",
          style: TextStyle(fontSize: 15.0, color: Colors.white),
        ),
      ),
    );
  }
}
