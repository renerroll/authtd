part of 'add_comment_cubit.dart';

abstract class AddCommentState {}

class AddCommentInitial extends AddCommentState {}
class AddCommentError extends AddCommentState {
  final String error;

  AddCommentError({required this.error});
}

class AddingComment extends AddCommentState {}
class CommentAdded extends AddCommentState {}