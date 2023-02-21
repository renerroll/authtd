import 'dart:async';
import 'package:authtd/cubit/comment_state.dart';
import 'package:authtd/data/models/comment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repository.dart';


class CommentsCubit extends Cubit<CommentsState> {
  final Repository repository;

  CommentsCubit({required this.repository}) : super(CommentsInitial());

  void fetchComments() {
    Timer(const Duration(seconds: 1), () {
      repository.fetchComments().then((comments) {
        emit(CommentsLoaded(comments: comments));
      });
    });
  }

  void updateCommentList() {
    final currentState = state;
    if (currentState is CommentsLoaded) {
      emit(CommentsLoaded(comments: currentState.comments));
    }
  }

  addComment(Comment comment) {
    final currentState = state;
    if (currentState is CommentsLoaded) {
      final commentList = currentState.comments;
      commentList.add(comment);
      emit(CommentsLoaded(comments: commentList));
    }
  }

  void deleteComment(Comment comment) {
    final currentState = state;
    if (currentState is CommentsLoaded) {
      final commentList = currentState.comments.where((element) => element.id != comment.id).toList();
      emit(CommentsLoaded(comments: commentList));
    }
  }

}