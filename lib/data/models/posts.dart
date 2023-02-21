class Post {
  String title;
  String body;
  bool isCompleted;
  int id;

  Post({
    required this.title,
    required this.body,
    required this.isCompleted,
    required this.id,
  });

  Post.fromJson(Map json):
    title = json.containsKey("title") ? json["title"] : "",
    body = json.containsKey("body") ? json["body"] : "",
    isCompleted = json.containsKey("isCompleted") && json["isCompleted"] == "true",
    id = json.containsKey("id") ? json["id"] : "";

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'isCompleted': isCompleted.toString(),
      'id': id,
    };
  }
}
