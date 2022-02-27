import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class database {
  void addUserInfo() {
    CollectionReference db = FirebaseFirestore.instance.collection('users');
    var currentuser = FirebaseAuth.instance.currentUser!;

    Map<String, dynamic> userInfo = {
      "name": currentuser.displayName!,
      "email": currentuser.email!,
      "image": currentuser.photoURL!,
    };

    db.doc(currentuser.email).set(userInfo);
  }

  void addFav(List fav) {
    CollectionReference db = FirebaseFirestore.instance.collection('users');
    Map<String, dynamic> favourites = {'fav': fav};
    var currentuser = FirebaseAuth.instance.currentUser!;

    db.doc(currentuser.email).update(favourites);
  }

  // void addData() async {
  //   var db = FirebaseFirestore.instance.collection('users');
  //   var currentuser = FirebaseAuth.instance.currentUser!;
  //   // db.add({"name": "tejas", "class": "TE"}).then((value) => print("sucess"));

  //   // print("working");

  //   Map<String, dynamic> userData = {
  //     "name": currentuser.displayName!,
  //     "email": currentuser.email!,
  //     "image": currentuser.photoURL!,
  //   };

  //   Map<String, dynamic> fav = {
  //     "fav": ['tejas', 'sonar', 'iconic'],
  //     "Asset": {'name': 'tejas', 'class': 'TE', 'surname': 'sonar'},
  //   };

  //   db.doc(currentuser.email).set(userData).then((value) => print('sucess'));
  //   db.doc(currentuser.email).update(fav).then((value) => print('sucess1'));
  // }
}
