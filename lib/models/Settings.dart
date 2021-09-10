import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings with ChangeNotifier {
  late String currency, perPage;

  void changeValues(String currency, String perPage) async {
    this.currency = currency;
    this.perPage = perPage;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("currency", currency);
    await prefs.setString("perPage", perPage);
    notifyListeners();
  }

}