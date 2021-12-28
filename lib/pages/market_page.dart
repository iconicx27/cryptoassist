// ignore_for_file: prefer_const_constructors

import 'package:cryptoassist/methods/google_signup.dart';
import 'package:cryptoassist/models/cryptocurrency.dart';
import 'package:cryptoassist/providers/market_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(child: MarketData()),
      drawer: MyDrawer(),
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
              style: TextStyle(letterSpacing: 2),
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
              style: TextStyle(letterSpacing: 2),
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
              style: TextStyle(letterSpacing: 2),
              textScaleFactor: 1.2,
            ),
          )
        ],
      ),
    );
  }
}

class MarketData extends StatelessWidget {
  const MarketData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Consumer<MarketProvider>(
              builder: (context, marketProvider, child) {
                if (marketProvider.isLoading == true) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (marketProvider.markets.length > 0) {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemCount: marketProvider.markets.length,
                      itemBuilder: (context, index) {
                        CryptoCurrency currentCrypto =
                            marketProvider.markets[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(currentCrypto.image!),
                          ),
                          title: Text(currentCrypto.name!),
                          subtitle: Text(currentCrypto.symbol!.toUpperCase()),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "₹ " + currentCrypto.currentPrice!,
                                style: TextStyle(fontSize: 15),
                              ),
                              Builder(
                                builder: (context) {
                                  double priceChange24 = double.parse(
                                      currentCrypto.priceChange24!);
                                  String priceChangePercentage = double.parse(
                                          currentCrypto
                                              .priceChangePercentage24!)
                                      .toStringAsFixed(2);
                                  if (priceChange24 < 0) {
                                    //negative
                                    return Text(
                                      "$priceChangePercentage" + "%",
                                      style: TextStyle(color: Colors.red),
                                    );
                                  }
                                  //positive
                                  return Text(
                                    "+" + "$priceChangePercentage" + "%",
                                    style: TextStyle(color: Colors.green),
                                  );
                                },
                              )
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    return Text('data not received!');
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
