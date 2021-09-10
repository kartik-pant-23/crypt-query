import 'package:crypt_query/models/Settings.dart';
import 'package:crypt_query/screens/Chatbot.dart';
import 'package:crypt_query/screens/Dashboard.dart';
import 'package:crypt_query/screens/Marketplace.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 1;
  List<String> _tabTitles = ["Marketplace", "Chat Assistant", "Dashboard"];
  List<Widget> _tabWidgets = [
    MarketplaceScreen(),
    ChatBotScreen(),
    DashboardScreen()
  ];

  PageController _controller = PageController(initialPage: 1);

  @override
  void initState() {
    initializePreferences();
    super.initState();
  }

  Future initializePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    context.read<Settings>().changeValues(
        prefs.getString("currency") ?? "INR",
        prefs.getString("perPage") ?? "20"
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff243b53),
        title: Text(_tabTitles[_currentIndex]),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Color(0xff243b53),
        onTap: (position) {
          setState(() => _controller.jumpToPage(position));
        },
        selectedItemColor: Colors.amber,
        unselectedItemColor: Color(0xfff0f4f8).withOpacity(0.75),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.euro), label: _tabTitles[0]),
          BottomNavigationBarItem(
              icon: Icon(Icons.android), label: _tabTitles[1]),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: _tabTitles[2])
        ],
      ),
      body: PageView(
        children: _tabWidgets,
        controller: _controller,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
