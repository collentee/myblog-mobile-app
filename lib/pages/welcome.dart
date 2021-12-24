import 'package:flutter/material.dart';
import 'package:myblog_app/pages/auth/signin.dart';
import 'package:myblog_app/pages/bloggers/bloggers.dart';
import 'package:myblog_app/pages/posts/posts.dart';
import 'package:myblog_app/pages/search/search.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Home();
  }
}

class _Home extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  int _currentIndex = 0;

  Widget selectedPage(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return Posts();
        break;

      case 1:
        return Bloggers();
        break;

      case 2:
        return Search();
        break;

      case 3:
        return Signin();
        break;

      default:
        return Signin();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AnimatedContainer(
      duration: Duration(
        milliseconds: 500,
      ),
      child: (SafeArea(
        top: true,
        child: Scaffold(
          body: selectedPage(_currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            iconSize: 16.0,
            items: [
              BottomNavigationBarItem(
                title: Text('Posts'),
                icon: Icon(Icons.list),
              ),
              BottomNavigationBarItem(
                title: Text('Bloggers'),
                icon: Icon(Icons.person),
              ),
              BottomNavigationBarItem(
                title: Text('Search'),
                icon: Icon(Icons.find_in_page_outlined),
              ),
              BottomNavigationBarItem(
                //label: 'Notices',
                title: Text('Profile'),
                icon: Icon(Icons.login),
              ),
            ],
            onTap: (index) {
              _currentIndex = index;
              setState(() {});
            },
          ),
        ),
      )),
    );
  }
}
