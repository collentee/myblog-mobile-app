import 'dart:convert';

List<User> usersFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

class User {
  int? id;
  String? name;
  String? image;
  String? email;
  String? token;

  User({
    this.id,
    this.name,
    this.image,
    this.email,
    this.token
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        image: json['user']['image'],
        email: json['user']['email'],
        token: json['token']
    );
  }


}