import 'dart:convert';

List<Blogger> bloggersFromJson(String str) =>
    List<Blogger>.from(json.decode(str).map((x) => Blogger.fromJson(x)));

class Blogger {
  int? id;
  String? name;
  //String? image;
  String? email;
  //String? blogger;
  String? date;

  Blogger({
    this.id,
    this.name,
    //this.image,
    this.email,
    //this.blogger,
    this.date,
  });

  Blogger.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    //image = json['image'];
    //blogger = json['blogger'];
    date = json['date'];
  }

}