// ignore_for_file: prefer_const_constructors

import 'package:cryptoassist/pages/home.dart';
import 'package:cryptoassist/pages/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something went Wrong!"),
            );
          } else if (snapshot.hasData) {
            return MarketPage();
          }

          return SignUp();
        },
      ),
    );
  }
}
