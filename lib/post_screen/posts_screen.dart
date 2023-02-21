import 'package:authtd/data/models/posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../const/strings.dart';
import '../cubit/posts_cubit.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PostsCubit>(context).fetchPosts();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Пости"),
          leading: InkWell(
            onTap: () => Navigator.pushNamed(context,
                HOME_ROUTE), 
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Icon(Icons.last_page_outlined),
            ),
          ),
          actions: [
            InkWell(
              onTap: () => Navigator.pushNamed(context, ADD_POST_ROUTE),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
        body: BlocBuilder<PostsCubit, PostsState>(
          builder: (context, state) {
            if (state is! PostsLoaded) {
              return const Center(child: CircularProgressIndicator());
            }
            final posts = (state).posts;
            return SingleChildScrollView(
              child: Column(
                children: posts.map((e) => _post(e, context)).toList(),
              ),
            );
          },
        ));
  }

  Widget _post(Post post, context) {
    return InkWell(
      onTap: () =>
          Navigator.pushNamed(context, EDIT_POST_ROUTE, arguments: post),
      child: Dismissible(
        key: Key("${post.id}"),
        confirmDismiss: (_) async {
          BlocProvider.of<PostsCubit>(context).changeCompletion(post);
          return false;
        },
        background: Container(
          color: Colors.indigo,
        ),
        child: _postTile(post, context),
      ),
    );
  }

  Widget _postTile(Post post, context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Column(children: [
            Text(
              post.title,
              style: (TextStyle(
                  color: Colors.black87, fontWeight: FontWeight.bold)),
            ),
            Text(post.body),
          ])),
          _completionIndicator(post),
        ],
      ),
    );
  }

  Widget _completionIndicator(Post post) {
    return Container(
      width: 20.0,
      height: 20.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        border: Border.all(
          width: 4.0,
          color: post.isCompleted ? Colors.green : Colors.red,
        ),
      ),
    );
  }

}
