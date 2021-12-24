import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myblog_app/models/bloggers.dart';
import 'package:myblog_app/utils/contants.dart';

class SingleBlogger extends StatelessWidget {

  final Blogger bloggerDetails;

  SingleBlogger(this.bloggerDetails);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Blogger Details',
              style: TextStyle(
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: kPrimaryColor.withOpacity(01),
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Container(
                  height: 100,
                  child: Icon(Icons.person, size: 64,),
                ),
                Text(bloggerDetails.name!,
                  style: TextStyle( color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                SizedBox(height: 8,),
                Text('email', style: TextStyle( color: kPrimaryColor, fontSize: 12),),
                Text(bloggerDetails.email!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}