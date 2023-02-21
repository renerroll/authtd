import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../cubit/add_comment_cubit.dart';
import '../cubit/comment_cubit.dart';
import '../cubit/comment_state.dart';

class AddCommentScreen extends StatelessWidget {
  final _controller = TextEditingController();
  final _bodycontroller = TextEditingController();
  final _mailcontroller = TextEditingController();

  AddCommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Додати Комментар"),
      ),
      body: BlocListener<CommentsCubit, CommentsState>(
        listener: (context, state) {
          if (state is CommentAdded) {
            Navigator.pop(context);
          } else if (state is AddCommentError) {
            Toast.show(
              state.toString(),
              duration: 3,
              backgroundColor: Colors.red,
              gravity: Toast.center,
            );
          }
        },
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: _body(context),
        ),
      ),
    );
  }

  Widget _body(context) {
    return Column(
      children: [
        TextField(
          autofocus: true,
          controller: _controller,
          decoration: InputDecoration(hintText: "Введіть імя..."),
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
            final name = _controller.text;
            final body = _bodycontroller.text;
            final email = _mailcontroller.text;
            final id = 1;
            BlocProvider.of<AddCommentCubit>(context)
                .addComment(body, name, email, id);
          },
          child: _addBtn(context),
        )
      ],
    );
  }

  Widget _addBtn(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: BlocBuilder<AddCommentCubit, AddCommentState>(
          builder: (context, state) {
            if (state is AddingComment) return CircularProgressIndicator();
            return Text(
              "Додати Пост",
              style: TextStyle(color: Colors.white),
            );
          },
        ),
      ),
    );
  }
}
