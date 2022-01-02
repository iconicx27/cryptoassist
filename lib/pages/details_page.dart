import 'package:cryptoassist/models/cryptocurrency.dart';
import 'package:cryptoassist/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;
  const DetailsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          child: Consumer<MarketProvider>(
            builder: (context, marketProvider, child) {
              CryptoCurrency selectedCrypto =
                  marketProvider.fetchCryptoById(widget.id);

              return ListView(
                children: [
                  ListTile(
                    //TODO
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(selectedCrypto.image!),
                    ),
                    title: Text(
                      selectedCrypto.name!,
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      "₹ " + selectedCrypto.currentPrice!,
                      style: TextStyle(fontSize: 17),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
