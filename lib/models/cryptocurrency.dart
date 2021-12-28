class CryptoCurrency {
  String? id;
  String? symbol;
  String? name;
  String? image;
  String? currentPrice;
  String? marketCap;
  String? marketCapRank;
  String? high24;
  String? low24;
  String? priceChange24;
  String? priceChangePercentage24;
  String? circulatingSupply;
  String? ath;
  String? atl;

  CryptoCurrency({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.high24,
    required this.low24,
    required this.priceChange24,
    required this.priceChangePercentage24,
    required this.circulatingSupply,
    required this.ath,
    required this.atl,
  });

  factory CryptoCurrency.fromJSON(Map<String, dynamic> map) {
    return CryptoCurrency(
        id: map['id'].toString(),
        symbol: map['symbol'].toString(),
        name: map['name'].toString(),
        image: map['image'].toString(),
        currentPrice: map['current_price'].toString(),
        marketCap: map['market_cap'].toString(),
        marketCapRank: map['market_cap_rank'].toString(),
        high24: map['high_24h'].toString(),
        low24: map['low_24h'].toString(),
        priceChange24: map['price_change_24h'].toString(),
        priceChangePercentage24: map['price_change_percentage_24h'].toString(),
        circulatingSupply: map['circulating_supply'].toString(),
        ath: map['ath'].toString(),
        atl: map['atl'].toString());
  }
}
