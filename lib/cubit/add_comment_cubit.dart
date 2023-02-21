import 'dart:async';
import 'package:authtd/cubit/comment_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository.dart';
part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentState> {

  final Repository repository;
  final CommentsCubit commentsCubit;

  AddCommentCubit({required this.repository, required this.commentsCubit}) : super(AddCommentInitial());
  void addComment(String body, String name, String email , int id) {

    if (name.isEmpty) {
      emit(AddCommentError(error: "commentar message is empty"));
      return;
    }

    emit(AddingComment());
    Timer(const Duration(seconds: 1), () {
      repository.addComment( body,  name,  email, id).then((comment) {
        if (comment != null) {
          commentsCubit.addComment(comment);
          emit(CommentAdded());
        }
      });
    });

  }
}