import 'package:flutter/material.dart';
import 'package:myblog_app/api/posts_api.dart';
import 'package:myblog_app/models/post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:myblog_app/pages/posts/post_single.dart';
import 'package:myblog_app/utils/contants.dart';

class MyPosts extends StatefulWidget {
  const MyPosts({Key? key}) : super(key: key);

  @override
  _MyPosts createState() => _MyPosts();
}

class _MyPosts extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Posts',
              style: TextStyle(
                //color: kSecondaryColor,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: kPrimaryColor.withOpacity(01),
            elevation: 0,
          ),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: fetchMyPosts(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        //print(snapshot.data.length);
                        final list = snapshot.data as List;
                        if (snapshot.data == null) {
                          return Center(
                            child: Text("No Pots Found!!!"),
                          );
                        }
                        return ListView.builder(
                            itemCount: list.length, //snapshot.data.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              Post posts = list[index];
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (context) =>
                                              SinglePost(list[index]))
                                  );
                                },
                                child: Column(
                                  children: [
                                    Container(
                                      height:200,
                                      child: CachedNetworkImage(
                                        imageUrl: imageURL + posts.image!,
                                      ),
                                    ),
                                    ListTile(
                                      title: Text(posts.title!,
                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                      subtitle: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('by: ' + posts.blogger!),
                                          Text(posts.date!, style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16,),
                                    Divider(),
                                    SizedBox(height: 16,),
                                  ],
                                ),
                              );
                            });
                      } else {
                        return Container(
                            alignment: Alignment.center,
                            child: Center(child: CircularProgressIndicator()));
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
