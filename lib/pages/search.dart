import 'package:cryptoassist/methods/firebase_database.dart';
import 'package:flutter/material.dart';

class SearchData extends StatelessWidget {
  SearchData({Key? key}) : super(key: key);

  // List fav = ['tejas', 'sonar'];
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          child: Text("add"),
          onPressed: () async {
            // database().addFav(fav);
          }),
    );
  }
}
