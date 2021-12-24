import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myblog_app/api/users_api.dart';
import 'package:myblog_app/models/post.dart';
import 'package:myblog_app/utils/contants.dart';


Future<List<Post>> fetchPosts() async {


  var url = Uri.parse(baseURL + "/posts/");
  print(url);

  final response = await http.get(url);


  return postsFromJson(response.body);
}
//my post
Future<List<Post>> fetchMyPosts() async {
  int userId = await getUserId();
  var url = Uri.parse(baseURL + "/posts/blogger/" + userId.toString());
  print(url);

  final response = await http.get(url);
  //if(response.statusCode==200)


  return postsFromJson(response.body);
}

// Create post
Future<int?> addPost (String title, String post, String? image) async {
  var url = Uri.parse(baseURL + "/posts");
  String token = await getUserToken();
  int userId = await getUserId();

  try {

    var body = json.encode({"title": title, "image": image, "body": post,
      "user_id": userId});
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    //print(token);
    final response = await http.post(url,
        headers: headers, body: body);


    print('res -> ' + response.body.toString());
    if (response.statusCode == 201) {

      return response.statusCode;
    }else{
      return response.statusCode;
    }


  }
  catch (e){

  }

}