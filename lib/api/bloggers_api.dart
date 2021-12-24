import 'package:http/http.dart' as http;
import 'package:myblog_app/models/bloggers.dart';
import 'package:myblog_app/utils/contants.dart';


Future<List<Blogger>> fetchBloggers() async {
  var url = Uri.parse(baseURL + "/bloggers");

  final response = await http.get(url);
  //if(response.statusCode==200)
  print(response.body);
  //List ranList = response.body;

  return bloggersFromJson(response.body);
}