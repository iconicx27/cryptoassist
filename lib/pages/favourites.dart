// ignore_for_file: non_constant_identifier_names, prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cryptoassist/models/cryptocurrency.dart';
import 'package:cryptoassist/providers/market_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouriteData extends StatelessWidget {
  FavouriteData({Key? key}) : super(key: key);
  var currentUser = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
