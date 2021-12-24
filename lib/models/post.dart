import 'dart:convert';

List<Post> postsFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

class Post {
  int? id;
  String? title;
  String? body;
  String? image;
  String? blogger;
  String? date;

  Post({
    this.id,
    this.title,
    this.image,
    this.body,
    this.blogger,
    this.date,
  });

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
    blogger = json['blogger'];
    date = json['date'];
  }

}