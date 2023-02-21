part of 'add_post_cubit.dart';

abstract class AddPostState {}

class AddPostInitial extends AddPostState {}
class AddPostError extends AddPostState {
  final String error;

  AddPostError({required this.error});
}

class AddingPost extends AddPostState {}
class PostAdded extends AddPostState {}