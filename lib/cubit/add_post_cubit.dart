import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository.dart';
import 'posts_cubit.dart';
part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {

  final Repository repository;
  final PostsCubit postsCubit;

  AddPostCubit({required this.repository, required this.postsCubit}) : super(AddPostInitial());
  void addPost(String title, String body) {

    if (title.isEmpty) {
      emit(AddPostError(error: "post message is empty"));
      return;
    }

    emit(AddingPost());
    Timer(const Duration(seconds: 1), () {
      repository.addPost(title, body).then((post) {
        if (post != null) {
          postsCubit.addPost(post);
          emit(PostAdded());
        }
      });
    });

  }
}