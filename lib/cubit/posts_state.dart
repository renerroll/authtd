part of 'posts_cubit.dart';

abstract class PostsState {}

class PostsInitial extends PostsState {}
class PostsLoaded extends PostsState {
  final List<Post> posts;

  PostsLoaded({required this.posts});
}