import 'dart:convert';

import 'package:crypt_query/config.dart';
import 'package:crypt_query/models/Currency.dart';
import 'package:http/http.dart' as http;

Future<List<Currency>?> loadCurrenciesData({required String currency, required String perPage, required String page}) async {
  try {
    var url = Uri.https(BASE_URL, GET_CURRENCIES, {
      "key": API_KEY,
      "interval": "1d",
      "convert": currency,
      "page": page,
      "per-page": perPage
    });
    http.Response response = await http.get(url);
    if(response.statusCode != 200) {
      print("LOADING_DATA_ERROR: ${response.body}");
      return null;
    }
    List<Currency> list = List.empty(growable: true);
    jsonDecode(response.body).forEach((item) => {
      list.add(Currency.fromJson(item))
    });
    return list;
  } catch(e) {
    print("LOADING_DATA_EXCEPTION: ${e.toString()}");
    return null;
  }
}