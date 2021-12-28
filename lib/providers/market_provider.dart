import 'dart:async';

import 'package:cryptoassist/methods/fetch_API_data.dart';
import 'package:cryptoassist/models/cryptocurrency.dart';
import 'package:flutter/cupertino.dart';

class MarketProvider extends ChangeNotifier {
  bool isLoading = true;
  List<CryptoCurrency> markets = [];

  MarketProvider() {
    fetchData();
  }

  void fetchData() async {
    List<dynamic> _markets = await API.getMarkets();

    List<CryptoCurrency> temp = [];
    for (var market in _markets) {
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);
      temp.add(newCrypto);
    }

    markets = temp;
    isLoading = false;
    notifyListeners();

    Timer(const Duration(seconds: 3), () {
      fetchData();
      print("data updated");
    });
  }
}
