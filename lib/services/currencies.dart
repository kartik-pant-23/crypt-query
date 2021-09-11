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
      list.add(Currency.fromJson(item, currency: currency))
    });
    return list;
  } catch(e) {
    print("LOADING_DATA_EXCEPTION: ${e.toString()}");
    return null;
  }
}

Future<List<Currency>?> getCurrencyDetailsList(List<String> ids) async {
  try {
    String _ids = "";
    ids.forEach((element) => _ids += element + "," );
    _ids.substring(0, _ids.length - 1);
    Uri url = Uri.https(BASE_URL, GET_DETAILS, {
      "key": API_KEY,
      "ids": _ids
    });
    http.Response response = await http.get(url);
    if(response.statusCode != 200) {
      print("LOADING_DETAILS_ERROR: ${response.body}");
      return null;
    }
    List<Currency> _list = List.empty(growable: true);
    jsonDecode(response.body).forEach((item) => {
      _list.add(Currency.detailsFromJson(item))
    });
    return _list;
  } catch(e) {
    print("LOADING_DETAIL_EXCEPTION: ${e.toString()}");
    return null;
  }
}

Future<Currency?> getCurrencyDetails(String ids) async {
  try {
    Uri url = Uri.https(BASE_URL, GET_DETAILS, {
      "key": API_KEY,
      "ids": ids
    });
    http.Response response = await http.get(url);
    if(response.statusCode != 200) {
      print("LOADING_DETAILS_ERROR: ${response.body}");
      return null;
    }
    return Currency.detailsFromJson(jsonDecode(response.body)[0] ?? {});
  } catch(e) {
    print("LOADING_DETAIL_EXCEPTION: ${e.toString()}");
    return null;
  }
}
