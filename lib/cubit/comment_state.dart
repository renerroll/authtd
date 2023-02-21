
import '../data/models/comment.dart';

abstract class CommentsState {}

class CommentsInitial extends CommentsState {}
class CommentsLoaded extends CommentsState {
  final List<Comment> comments;

  CommentsLoaded({required this.comments});
}