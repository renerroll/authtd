import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/models/posts.dart';
import '../data/repository.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final Repository repository;

  PostsCubit({required this.repository}) : super(PostsInitial());

  void fetchPosts() {
    Timer(const Duration(seconds: 1), () {
      repository.fetchPosts().then((posts) {
        emit(PostsLoaded(posts: posts));
      });
    });
  }

  void changeCompletion(Post post) {
    repository.changeCompletion(!post.isCompleted, post.id).then((isChanged) {
      if (isChanged) {
        post.isCompleted = !post.isCompleted;
        updatePostList();
      }
    });
  }

  void updatePostList() {
    final currentState = state;
    if (currentState is PostsLoaded) {
      emit(PostsLoaded(posts: currentState.posts));
    }
  }

  addPost(Post post) {
    final currentState = state;
    if (currentState is PostsLoaded) {
      final postList = currentState.posts;
      postList.add(post);
      emit(PostsLoaded(posts: postList));
    }
  }

  void deletePost(Post post) {
    final currentState = state;
    if (currentState is PostsLoaded) {
      final postList = currentState.posts.where((element) => element.id != post.id).toList();
      emit(PostsLoaded(posts: postList));
    }
  }

  addComment(Post post) {
    final currentState = state;
    if (currentState is PostsLoaded) {
      final postList = currentState.posts;
      postList.add(post);
      emit(PostsLoaded(posts: postList));
    }
  }

}
