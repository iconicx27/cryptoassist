// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cryptoassist/methods/firebase_database.dart';
import 'package:cryptoassist/models/cryptocurrency.dart';
import 'package:cryptoassist/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'details_page.dart';

class MarketData extends StatelessWidget {
  MarketData({Key? key}) : super(key: key);

  static List favCrypto = [];

  void showfavSnackbar(BuildContext context, String id, String symbol) {
    symbol = symbol.toUpperCase();
    var snackbar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.heart,
            size: 15,
            color: Colors.white,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
              child: Text(
            "$symbol Added to Favourites!",
            style: TextStyle(
              fontSize: 16,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ))
        ],
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(vertical: 80, horizontal: 15),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          favCrypto.remove(id);
          database().addFav(favCrypto);
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void showNotAddedSnackbar(BuildContext context, String id, String symbol) {
    symbol = symbol.toUpperCase();
    var snackbar = SnackBar(
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            FontAwesomeIcons.exclamationCircle,
            size: 15,
            color: Colors.white,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
              child: Text(
            "$symbol Already in Favourites",
            style: TextStyle(
              fontSize: 16,
              fontFamily: GoogleFonts.poppins().fontFamily,
            ),
          ))
        ],
      ),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.symmetric(vertical: 80, horizontal: 15),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

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
                  if (marketProvider.markets.isNotEmpty) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        await marketProvider.fetchData();
                      },
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        itemCount: marketProvider.markets.length,
                        itemBuilder: (context, index) {
                          CryptoCurrency currentCrypto =
                              marketProvider.markets[index];
                          return Slidable(
                            startActionPane: ActionPane(
                              motion: DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (BuildContext) {},
                                  spacing: 4,
                                  backgroundColor: Colors.blue.shade300,
                                  foregroundColor: Colors.grey.shade800,
                                  icon: FontAwesomeIcons.rupeeSign,
                                  label: 'Assets',
                                ),
                                SlidableAction(
                                  onPressed: (BuildContext) {
                                    if (!favCrypto.contains(currentCrypto.id)) {
                                      favCrypto.add(currentCrypto.id!);
                                      showfavSnackbar(
                                          context,
                                          currentCrypto.id!,
                                          currentCrypto.symbol!);
                                      database().addFav(favCrypto);
                                    } else {
                                      showNotAddedSnackbar(
                                          context,
                                          currentCrypto.id!,
                                          currentCrypto.symbol!);
                                    }
                                  },
                                  spacing: 4,
                                  backgroundColor: Colors.pink.shade300,
                                  foregroundColor: Colors.white,
                                  icon: FontAwesomeIcons.heart,
                                  label: "Fav's",
                                ),
                              ],
                            ),
                            endActionPane: ActionPane(
                              motion: DrawerMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (BuildContext) {
                                    if (!favCrypto.contains(currentCrypto.id)) {
                                      favCrypto.add(currentCrypto.id!);
                                      showfavSnackbar(
                                          context,
                                          currentCrypto.id!,
                                          currentCrypto.symbol!);
                                      database().addFav(favCrypto);
                                    } else {
                                      showNotAddedSnackbar(
                                          context,
                                          currentCrypto.id!,
                                          currentCrypto.symbol!);
                                    }
                                  },
                                  spacing: 4,
                                  backgroundColor: Colors.pink.shade300,
                                  foregroundColor: Colors.white,
                                  icon: FontAwesomeIcons.heart,
                                  label: "Fav's",
                                ),
                                SlidableAction(
                                  onPressed: (BuildContext) {},
                                  spacing: 4,
                                  backgroundColor: Colors.blue.shade300,
                                  foregroundColor: Colors.grey.shade800,
                                  icon: FontAwesomeIcons.rupeeSign,
                                  label: 'Assets',
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsPage(
                                      id: currentCrypto.id!,
                                    ),
                                  ),
                                );
                              },
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(currentCrypto.image!),
                              ),
                              title: Text(currentCrypto.name!),
                              subtitle:
                                  Text(currentCrypto.symbol!.toUpperCase()),
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
                                      String priceChangePercentage =
                                          double.parse(currentCrypto
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
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => Divider(
                          // indent: 8,
                          // endIndent: 8,
                          height: 12,
                          thickness: 0,
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return Center(
                        child: Text(
                      'Something went Wrong!',
                      style: TextStyle(fontSize: 20),
                    ));
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
