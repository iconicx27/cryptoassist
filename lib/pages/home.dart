// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:cryptoassist/methods/google_signup.dart';
import 'package:cryptoassist/models/cryptocurrency.dart';
import 'package:cryptoassist/pages/details_page.dart';
import 'package:cryptoassist/pages/search.dart';
import 'package:cryptoassist/providers/market_provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'asset.dart';
import 'favourites.dart';
import 'market.dart';
import 'profile.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  int currentIndex = 0;
  final screens = [
    SafeArea(child: MarketData()),
    SafeArea(child: FavouriteData()),
    SafeArea(child: SearchData()),
    SafeArea(child: AssetData()),
    SafeArea(child: ProfileData()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.grey.shade900,
        height: 62,
        index: currentIndex,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: [
          Icon(
            FontAwesomeIcons.poll,
            color: Colors.white,
          ),
          Icon(
            FontAwesomeIcons.heart,
            color: Colors.white,
          ),
          Icon(
            FontAwesomeIcons.search,
            color: Colors.white,
          ),
          Icon(
            FontAwesomeIcons.rupeeSign,
            color: Colors.white,
          ),
          Icon(
            FontAwesomeIcons.user,
            color: Colors.white,
          ),
        ],
      ),
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
                FontAwesomeIcons.alignLeft,
                size: 22,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        title: Text(
          "CRYPTO ASSIST",
          style: TextStyle(
            letterSpacing: 3,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogout();
              },
              icon: Icon(
                FontAwesomeIcons.signOutAlt,
                size: 22,
              ))
        ],
      ),
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      // drawer: MyDrawer(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            padding: EdgeInsets.zero,
            child: UserAccountsDrawerHeader(
              margin: EdgeInsets.zero,
              accountName: Text(
                user.displayName!,
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text(
                user.email!,
                style: TextStyle(fontSize: 14),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(user.photoURL!),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(
              FontAwesomeIcons.home,
              color: Colors.black,
              size: 20,
            ),
            title: Text(
              "Home",
              textScaleFactor: 1.2,
            ),
          ),
          const ListTile(
            leading: Icon(
              FontAwesomeIcons.user,
              color: Colors.black,
              size: 20,
            ),
            title: Text(
              "Profile",
              textScaleFactor: 1.2,
            ),
          ),
          const ListTile(
            leading: Icon(
              FontAwesomeIcons.envelope,
              color: Colors.black,
              size: 20,
            ),
            title: Text(
              "Mail",
              textScaleFactor: 1.2,
            ),
          )
        ],
      ),
    );
  }
}
