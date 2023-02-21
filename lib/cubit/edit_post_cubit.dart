import 'package:authtd/cubit/posts_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/posts.dart';
import '../data/repository.dart';

part 'edit_post_state.dart';

class EditPostCubit extends Cubit<EditPostState> {
  final Repository repository;
  final PostsCubit postsCubit;

  EditPostCubit({required this.repository, required this.postsCubit})
      : super(EditPostInitial());

  void deletePost(Post post) {
    repository.deletePost(post.id).then((isDeleted) {
      if (isDeleted) {
        postsCubit.deletePost(post);
        emit(PostEdited());
      }
    });
  }

  void updatePost(Post post, String title, String body) {
    if (title.isEmpty) {
      emit(EditPostError(error: "Message is empty"));
      return;
    }

    repository
        .updatePost(
      title,
      body,
      post.id,
    )
        .then((isEdited) {
      if (isEdited) {
        post.body = body;
        post.title = title;
        postsCubit.updatePostList();
        emit(PostEdited());
      }
    });
  }
}
