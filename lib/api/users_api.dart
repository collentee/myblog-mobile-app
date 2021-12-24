import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


// get user userId
Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('userId') ?? 0;
}
// get user token
Future<String> getUserToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}
// get user name
Future<String> getUserName() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('name') ?? '';
}

