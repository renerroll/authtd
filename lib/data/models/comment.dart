
class Comment {
  final int id;
  final int postId;
  final String name;
  final String email;
  final String body;

  Comment({
    required this.id,
    required this.postId,
    required this.name,
    required this.email,
    required this.body,
  });

  Comment.fromJson(Map json):
    name = json.containsKey("name") ? json["name"] : "",
    body = json.containsKey("body") ? json["body"] : "",
    postId = json.containsKey("postId") ? json["postId"] : "",
    email = json.containsKey("email") ? json["email"] : "",
    id = json.containsKey("id") ? json["id"] : "";

}
