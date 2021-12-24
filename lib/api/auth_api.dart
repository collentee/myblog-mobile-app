import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myblog_app/models/user.dart';
import 'package:myblog_app/utils/contants.dart';
import 'package:shared_preferences/shared_preferences.dart';


//log in
Future<int?> login(String username, String password) async {
  try {
    var body = json.encode({"email": username, "password": password});

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    final response =
    await http.post(Uri.parse(baseURL + "/login"), body: body, headers: headers);
    var responseJson = User.fromJson(jsonDecode(response.body));

    print(responseJson.email);


    if (response.statusCode == 200) {

      saveLoggedUser(responseJson);
    }
    if (response.statusCode > 200) {
      print("invalid userdetails");

    }
    return response.statusCode;



  } catch (e) {
    print(e.toString());

  }
}

//save user to sharedpref
Future<void> saveLoggedUser(User user) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setInt('userId', user.id ?? 0);
  await pref.setString('name', user.name ?? '');
  await pref.setString('token', user.token ?? '');

  //print('savedname ->' + pref.getString('name').toString());
}

//signup
Future<int?> signUpUser(
    String email, String name, String password) async {
  try {
    var body = json.encode({
      "email": email,
      "name": name,
      "image": 'no_image.png',
      "password": password
    });

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    //print(body);

    final response =
    await http.post(Uri.parse(baseURL + "/signup"), body: body, headers: headers);

    var responseJson = User.fromJson(jsonDecode(response.body));

    //print(response.statusCode);
    if (response.statusCode == 201) {
      saveLoggedUser(responseJson);

    }
    if (response.statusCode > 200) {
      print(response.body);

    }
    return response.statusCode;

    return response.statusCode;
  } catch (e) {
    //print(e.toString());
  }
}