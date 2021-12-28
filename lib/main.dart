// ignore_for_file: prefer_const_constructors

import 'package:cryptoassist/methods/google_signup.dart';
import 'package:cryptoassist/methods/themes.dart';
import 'package:cryptoassist/pages/home_page.dart';
import 'package:cryptoassist/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // create: (context) => GoogleSignInProvider(),
      providers: [
        ChangeNotifierProvider<GoogleSignInProvider>(
            create: (context) => GoogleSignInProvider()),
        ChangeNotifierProvider<MarketProvider>(
            create: (context) => MarketProvider())
      ],
      child: MaterialApp(
        title: 'CryptoAssist',
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme(context),
        darkTheme: MyThemes.darkTheme(context),
        home: HomePage(),
      ),
    );
  }
}
