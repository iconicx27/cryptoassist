// ignore_for_file: prefer_const_constructors

import 'package:cryptoassist/methods/google_signup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 80.0,
            ),
            Image.asset(
              "assets/images/signup_image.png",
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 40.0,
            ),
            Text(
              "Welcome to CryptoAssist",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(280, 50), primary: Colors.grey.shade800),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);

                  provider.googleLogin();
                },
                icon: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text("Sign Up with Google",
                    style: TextStyle(color: Colors.white, fontSize: 17)))
          ],
        ),
      ),
    );
  }
}
