import 'package:cryptoassist/models/cryptocurrency.dart';
import 'package:cryptoassist/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'details_page.dart';

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
                    return RefreshIndicator(
                      onRefresh: () async {
                        await marketProvider.fetchData();
                      },
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        itemCount: marketProvider.markets.length,
                        itemBuilder: (context, index) {
                          CryptoCurrency currentCrypto =
                              marketProvider.markets[index];
                          return ListTile(
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
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  NetworkImage(currentCrypto.image!),
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
