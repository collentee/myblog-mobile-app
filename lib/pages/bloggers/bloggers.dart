import 'package:flutter/material.dart';
import 'package:myblog_app/api/bloggers_api.dart';
import 'package:myblog_app/models/bloggers.dart';
import 'package:myblog_app/pages/bloggers/blogger.dart';
import 'package:myblog_app/utils/contants.dart';

class Bloggers extends StatefulWidget {
  const Bloggers({Key? key}) : super(key: key);

  @override
  _Bloggers createState() => _Bloggers();
}

class _Bloggers extends State<Bloggers> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Bloggers',
              style: TextStyle(
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
                    future: fetchBloggers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final list = snapshot.data as List;
                        if (snapshot.data == null) {
                          return Center(
                            child: Text("No Bloggers Found!!!"),
                          );
                        }
                        return ListView.builder(
                            itemCount: list.length, //snapshot.data.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, index) {
                              Blogger blogger = list[index];
                              return Column(
                                children: [
                                  Container(
                                    color: (index % 2 == 0)
                                        ? kBackgroundColor
                                        : kPrimaryColor.withOpacity(0.04),
                                    child: ListTile(
                                      leading:Icon(Icons.person),
                                      title: Text(blogger.name!),
                                      trailing: Text('>',),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    SingleBlogger(list[index]))
                                        );
                                      },
                                    ),
                                  ),
                                  //Divider(),
                                ],
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
