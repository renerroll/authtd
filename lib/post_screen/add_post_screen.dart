import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import '../cubit/add_post_cubit.dart';

class AddPostScreen extends StatelessWidget {
  final _controller = TextEditingController();
  final _bodycontroller = TextEditingController();

  AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Додати Пост"),
      ),
      body: BlocListener<AddPostCubit, AddPostState>(
        listener: (context, state) {
          if (state is PostAdded) {
            Navigator.pop(context);
          } else if (state is AddPostError) {
            Toast.show(
              state.error,
              duration: 3,
              backgroundColor: Colors.red,
              gravity: Toast.center,
            );
          }
        },
        child: Container(
          margin: EdgeInsets.all(20.0),
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
          decoration: InputDecoration(hintText: "Введіть заголовок..."),
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
            final title = _controller.text;
            final body = _bodycontroller.text;
            BlocProvider.of<AddPostCubit>(context).addPost(title, body);
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
        child: BlocBuilder<AddPostCubit, AddPostState>(
          builder: (context, state) {
            if (state is AddingPost) return CircularProgressIndicator();
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
