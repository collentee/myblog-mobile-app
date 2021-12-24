import 'package:flutter/material.dart';
import 'package:myblog_app/models/post.dart';
import 'package:myblog_app/utils/contants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SinglePost extends StatelessWidget {

  final Post postDetails;

  SinglePost(this.postDetails);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Post',
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
                  height:200,
                  child: CachedNetworkImage(
                    imageUrl: imageURL + postDetails.image!,
                  ),
                ),
                Text(postDetails.title!,
                  style: TextStyle( color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('by: ' + postDetails.blogger!),
                    Text(postDetails.date!, style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.w600),),
                  ],
                ),
                SizedBox(height: 16,),
                Text(postDetails.body!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}