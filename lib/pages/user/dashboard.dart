import 'package:flutter/material.dart';
import 'package:myblog_app/api/users_api.dart';
import 'package:myblog_app/pages/posts/add_post.dart';
import 'package:myblog_app/pages/posts/my_posts.dart';
import 'package:myblog_app/pages/welcome.dart';
import 'package:myblog_app/utils/contants.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  String? myName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    uName();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(
            //color: kSecondaryColor,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimaryColor.withOpacity(01),
        elevation: 0,

      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Hello '+ myName.toString(),
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
          ) ,
          ListTile(
            title: Text('My Posts'),
            leading: Icon(Icons.list),
            onTap: (){
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => MyPosts()),
              );
            },
          ),
          ListTile(
            title: Text('Create Post'),
            leading: Icon(Icons.add),
            onTap: (){

              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => AddPost()),
              );
            },
          ),
          ListTile(
            title: Text('My Profile'),
            leading: Icon(Icons.verified_user_outlined),
            onTap: (){},
          ),
          ListTile(
            title: Text('Sign Out'),
            leading: Icon(Icons.logout),
            onTap: (){
              Navigator.pushAndRemoveUntil(
                context,
                new MaterialPageRoute(
                    builder: (context) => Home()),
                    (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Future<String?> uName() async {
    return myName = await getUserName();

  }
}
