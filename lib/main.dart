import 'package:crypt_query/models/Settings.dart';
import 'package:crypt_query/screens/HomeScreen.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

void main() => runApp(ChangeNotifierProvider(
  create: (_) => Settings(),
  child: const CryptQueryHome()
));

class CryptQueryHome extends StatelessWidget {
  const CryptQueryHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Crypt Query",
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Raleway",
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Color(0xfff0f4f8)),
          bodyText2: TextStyle(color: Color(0xfff0f4f8))
        ),
        scaffoldBackgroundColor: Color(0xff102a43),
        primaryColor: Color(0xff627d98),
        accentColor: Color(0xffbcccdc),
        primarySwatch: MaterialColor(
          0xff627d98,
          {
            50: Color(0xfff0f4f8),
            100: Color(0xffd9e2ec),
            200: Color(0xffbcccdc),
            300: Color(0xff9fb3c8),
            400: Color(0xff829ab1),
            500: Color(0xff627d98),
            600: Color(0xff486581),
            700: Color(0xff334e68),
            800: Color(0xff243b53),
            900: Color(0xff102a43),
          }
        )
      ),
      home: HomeScreen()
    );
  }
}
