import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:myblog_app/api/auth_api.dart';
import 'package:myblog_app/api/posts_api.dart';
import 'package:myblog_app/api/users_api.dart';
import 'package:myblog_app/pages/user/dashboard.dart';
import 'package:myblog_app/utils/contants.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  final TextEditingController myTitle = TextEditingController();
  final TextEditingController mybody = TextEditingController();


  //form key
  final _formKey = GlobalKey<FormState>();

  File? _imageFile;
  final _picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null){
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Get base64 encoded image
  String? getStringImage(File? file) {
    if (file == null) return null ;
    return base64Encode(file.readAsBytesSync());
  }

  //
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 32), child: Text("Adding post...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Add new post',
              style: TextStyle(
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: kPrimaryColor.withOpacity(01),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Flexible(
                        child: TextFormField(
                            controller: myTitle,
                            keyboardType: TextInputType.text,
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText: 'Title',
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Title can not be empty';
                              }
                              onSaved:
                                  (val) {
                                setState(() {
                                  myTitle.text = val;
                                });
                              };
                            }),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Flexible(
                        child: TextFormField(
                            controller: mybody,
                            keyboardType: TextInputType.text,
                            autofocus: true,
                            decoration: InputDecoration(
                              labelText: 'Body',
                            ),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return 'Body can not be empty';
                              }
                              onSaved:
                                  (val) {
                                setState(() {
                                  mybody.text = val;
                                });
                              };
                            }),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        decoration: BoxDecoration(
                            image: _imageFile == null ? null : DecorationImage(
                                image: FileImage(_imageFile ?? File('')),
                                fit: BoxFit.cover
                            )
                        ),
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.image, size:50, color: Colors.black38),
                            onPressed: (){
                              getImage();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.0,
                      ),
                      Container(
                        color: kPrimaryColor,
                        width: 300,
                        child: TextButton(
                          child: Text(
                            'Add Post',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          onPressed: () {
                            setState(() {
                              if ((myTitle.text == "") &&
                                  (mybody.text == "")) {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: new Text("MISSING DETAILS!!!"),
                                        content: new Text(
                                            "Missing Information!!!\nTitle or Body can not be blank."),
                                        actions: <Widget>[
                                          new TextButton(
                                            child: new Text('OK'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                final form = _formKey.currentState;
                                if (form!.validate()) {
                                  form.save();

                                  CircularProgressIndicator();
                                  showLoaderDialog(context);
                                  String? image = _imageFile ==  null ? null : getStringImage(_imageFile);

                                  addPost(myTitle.text, mybody.text, image!)
                                      .then((value) {
                                    if (value == 201) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        new MaterialPageRoute(
                                            builder: (context) => Dashboard()),
                                            (Route<dynamic> route) => false,
                                      );
                                    } else {
                                      print(value.toString());
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                              new Text("POSTING FAILED!!!"),
                                              content: new Text(
                                                  "Please try again."),
                                              actions: <Widget>[
                                                new TextButton(
                                                  child: new Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  });
                                }
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


}
