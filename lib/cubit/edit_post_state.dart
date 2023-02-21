part of 'edit_post_cubit.dart';

abstract class EditPostState {}

class EditPostInitial extends EditPostState {}
class EditPostError extends EditPostState {
  final String error;

  EditPostError({required this.error});
}

class PostEdited extends EditPostState {}