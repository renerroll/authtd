import 'package:authtd/data/models/comment.dart';
import 'models/posts.dart';
import 'network_service.dart';

class Repository {
  final NetworkService networkService;

  Repository({required this.networkService});

  Future<List<Post>> fetchPosts() async {
    final postsRaw = await networkService.fetchPosts();
    return postsRaw.map((e) => Post.fromJson(e)).toList();
  }

  Future<bool> changeCompletion(bool isCompleted, int id) async {
    final patchObj = {"isCompleted": isCompleted.toString()};
    return await networkService.patchPost(patchObj, id);
  }

  Future<Post?> addPost(String title, String body) async {
    final postObj = {"post": title, "body": body, "isCompleted": "false"};
    final postMap = await networkService.addPost(postObj);
    if (postMap == null) return null;

    return Post.fromJson(postMap);
  }

  Future<bool> deletePost(int id) async {
    return await networkService.deletePost(id);
  }

  Future<bool> updatePost(String title, String body, int id) async {
    final patchObj = {"post": title, "body": body};
    return await networkService.patchPost(patchObj, id);
  }

  Future<List<Comment>> fetchComments() async {
    final commentsRaw = await networkService.fetchComments();
    return commentsRaw.map((e) => Comment.fromJson(e)).toList();
  }

  Future<Comment?> addComment(String body,  String email, String name, int id) async {
    final commentObj = {"body": body, "email": email, "name": name};
    final commentMap = await networkService.addComment(commentObj, id);
    if (commentMap == null) return null;
    return Comment.fromJson(commentMap);
  }
}
