class Currency {
  late String name, id, symbol, logoUrl;
  String? price, priceDelta;
  String? description, websiteUrl, githubUrl, twitterUrl, bitCoinTalkUrl;

  Currency.fromJson(jsonObject, {String? currency = "INR"}) {
    String currencySymbol = "";
    switch(currency) {
      case "INR": currencySymbol = '₹';
      break;
      case "USD": currencySymbol = '\$';
      break;
      default: currencySymbol = '€';
    }

    id = jsonObject["id"] ?? "-";
    name = jsonObject["name"] ?? "-";
    symbol = jsonObject["symbol"] ?? "-";
    price = double.parse(jsonObject["price"] ?? "0.00").toStringAsFixed(2);
    price = addCurrencySymbol(price, currencySymbol);
    priceDelta = double.parse(jsonObject["1d"]["price_change"]).toStringAsFixed(2);
    priceDelta = addCurrencySymbol(priceDelta, currencySymbol);
    logoUrl = jsonObject["logo_url"];
  }

  String addCurrencySymbol(String? val, String symbol) {
    String modVal = "";
    if(val?.startsWith("-") ?? false) {
      modVal = "-";
      val = val?.substring(1);
    }
    modVal = modVal + symbol + val! ?? "";
    return modVal;
  }

  Currency.detailsFromJson(jsonObject) {
    id = jsonObject["id"] ?? "-";
    name = jsonObject["name"] ?? "-";
    symbol = jsonObject["original_symbol"] ?? "-";
    description = jsonObject["description"];
    websiteUrl = jsonObject["website_url"];
    githubUrl = jsonObject["github_url"];
    twitterUrl = jsonObject["twitter_url"];
    bitCoinTalkUrl = jsonObject["bitcointalk_url"];
  }

}