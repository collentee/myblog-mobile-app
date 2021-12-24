import 'package:flutter/material.dart';
import 'package:myblog_app/utils/contants.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seach',
          style: TextStyle(
            //color: kSecondaryColor,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: kPrimaryColor.withOpacity(01),
        elevation: 0,
      ),
      body: Center(child: Text(' Search Page here')),
    );
  }
}
