class Currency {

  late String name, id, symbol, logoUrl;
  String? price, priceDelta, currency;

  Currency.fromJson(jsonObject, {String? currency = "INR"}) {
    id = jsonObject["id"] ?? "-";
    name = jsonObject["name"] ?? "-";
    symbol = jsonObject["symbol"] ?? "-";
    price = double.parse(jsonObject["price"] ?? "0.00").toStringAsFixed(2);
    priceDelta = double.parse(jsonObject["1d"]["price_change"]).toStringAsFixed(2);
    this.currency = currency;
    logoUrl = jsonObject["logo_url"];
  }

}